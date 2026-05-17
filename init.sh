#!/bin/bash
# init.sh — Verificación e inicialización del harness
# Versión: 1.0.0 | Fecha: 2026-05-16

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

echo "=========================================="
echo "  Harness Adaptado — Verificación"
echo "=========================================="
echo ""

# Función para reportar error
error() {
    echo -e "${RED}❌ ERROR:${NC} $1"
    ((ERRORS++))
}

# Función para reportar warning
warning() {
    echo -e "${YELLOW}⚠️  WARNING:${NC} $1"
    ((WARNINGS++))
}

# Función para reportar éxito
ok() {
    echo -e "${GREEN}✅${NC} $1"
}

# ============================================================
# 1. Verificar archivos obligatorios
# ============================================================
echo "--- Archivos obligatorios ---"

for file in "AGENTS.md" "CHECKPOINTS.md" "feature_list.json"; do
    if [ -f "$file" ]; then
        ok "$file presente"
    else
        error "$file NO encontrado"
    fi
done

# ============================================================
# 2. Verificar directorios obligatorios
# ============================================================
echo ""
echo "--- Directorios obligatorios ---"

for dir in "docs" "specs" "progress"; do
    if [ -d "$dir" ]; then
        ok "$dir/ presente"
    else
        error "$dir/ NO encontrado"
    fi
done

# ============================================================
# 3. Verificar archivos dentro de docs/
# ============================================================
echo ""
echo "--- Documentación ---"

for file in "docs/specs.md" "docs/conventions.md" "docs/architecture.md" "docs/verification.md"; do
    if [ -f "$file" ]; then
        ok "$file presente"
    else
        warning "$file NO encontrado"
    fi
done

# ============================================================
# 4. Verificar feature_list.json (estructura básica)
# ============================================================
echo ""
echo "--- feature_list.json ---"

if [ -f "feature_list.json" ]; then
    if python3 -c "import json; data=json.load(open('feature_list.json')); assert 'features' in data; assert 'rules' in data" 2>/dev/null; then
        ok "feature_list.json es JSON válido con estructura correcta"

        # Verificar máximo 1 in_progress
        IN_PROGRESS=$(python3 -c "import json; data=json.load(open('feature_list.json')); print(len([f for f in data['features'] if f.get('status')=='in_progress']))" 2>/dev/null || echo "0")
        if [ "$IN_PROGRESS" -le 1 ]; then
            ok "Máximo 1 feature in_progress ($IN_PROGRESS)"
        else
            error "Hay $IN_PROGRESS features in_progress (máximo permitido: 1)"
        fi

        # Contar features
        TOTAL=$(python3 -c "import json; data=json.load(open('feature_list.json')); print(len(data['features']))" 2>/dev/null || echo "0")
        PENDING=$(python3 -c "import json; data=json.load(open('feature_list.json')); print(len([f for f in data['features'] if f.get('status')=='pending']))" 2>/dev/null || echo "0")
        SPEC_READY=$(python3 -c "import json; data=json.load(open('feature_list.json')); print(len([f for f in data['features'] if f.get('status')=='spec_ready']))" 2>/dev/null || echo "0")
        DONE=$(python3 -c "import json; data=json.load(open('feature_list.json')); print(len([f for f in data['features'] if f.get('status')=='done']))" 2>/dev/null || echo "0")

        echo "   Features: $TOTAL total | $PENDING pending | $SPEC_READY spec_ready | $IN_PROGRESS in_progress | $DONE done"
    else
        error "feature_list.json no tiene la estructura esperada"
    fi
else
    error "No se pudo verificar feature_list.json"
fi

# ============================================================
# 5. Verificar specs/ (si hay features con sdd: true)
# ============================================================
echo ""
echo "--- Specs ---"

SDD_FEATURES=$(python3 -c "
import json
data = json.load(open('feature_list.json'))
for f in data.get('features', []):
    if f.get('sdd') and f.get('status') in ['spec_ready', 'in_progress', 'done']:
        print(f['id'])
" 2>/dev/null || true)

if [ -n "$SDD_FEATURES" ]; then
    for fid in $SDD_FEATURES; do
        if [ -d "specs/$fid" ]; then
            ok "specs/$fid/ existe"
            for sfile in "requirements.md" "design.md" "tasks.md"; do
                if [ -f "specs/$fid/$sfile" ]; then
                    ok "  specs/$fid/$sfile presente"
                else
                    error "  specs/$fid/$sfile NO encontrado"
                fi
            done
        else
            error "specs/$fid/ NO existe (feature con sdd:true en estado avanzado)"
        fi
    done
else
    echo "   No hay features con sdd:true en estado spec_ready+ (omitido)"
fi

# ============================================================
# 6. Verificar tests (si existe src/ o tests/)
# ============================================================
echo ""
echo "--- Tests ---"

if [ -d "tests" ] || [ -d "test" ]; then
    TEST_DIR="tests"
    [ -d "test" ] && TEST_DIR="test"
    TEST_COUNT=$(find "$TEST_DIR" -name "test_*.py" -o -name "*_test.py" | wc -l)
    if [ "$TEST_COUNT" -gt 0 ]; then
        ok "Directorio de tests encontrado ($TEST_COUNT archivos)"

        # Intentar ejecutar tests si pytest está disponible
        if command -v pytest &> /dev/null; then
            echo "   Ejecutando tests..."
            if pytest "$TEST_DIR" -q --tb=short 2>/dev/null; then
                ok "Todos los tests pasan"
            else
                warning "Algunos tests fallan (ver output arriba)"
            fi
        else
            warning "pytest no instalado, no se ejecutaron tests"
        fi
    else
        warning "Directorio de tests vacío"
    fi
else
    warning "No se encontró directorio tests/ (puede ser normal para proyecto nuevo)"
fi

# ============================================================
# 7. Resumen
# ============================================================
echo ""
echo "=========================================="
echo "  RESUMEN"
echo "=========================================="

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}🎉 TODO VERDE — El harness está listo${NC}"
    echo ""
    echo "Próximo paso: Abre feature_list.json y verifica que haya"
    echo "al menos una feature con status='pending' y sdd=true"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  WARNINGS: $WARNINGS — El harness funciona pero revisa las advertencias${NC}"
    exit 0
else
    echo -e "${RED}❌ ERRORES: $ERRORS | WARNINGS: $WARNINGS — Corrige los errores antes de continuar${NC}"
    exit 1
fi
