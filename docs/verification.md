# docs/verification.md — Verificación y Validación

> Cómo demostrar que una feature funciona correctamente.

## Pirámide de Verificación

```
         ┌─────────┐
         │  E2E    │  ← Tests de integración completa
         │ (pocos) │
        ┌┴─────────┴┐
        │  Service  │  ← Tests de lógica de negocio
        │  (varios) │
       ┌┴───────────┴┐
       │   Unit      │  ← Tests de funciones individuales
       │  (muchos)   │
      ┌┴─────────────┴┐
      │   Static      │  ← Linting, type checking
      │  (siempre)    │
      └───────────────┘
```

## Tests Unitarios

- Cada función pública debe tener al menos un test.
- Cada `R<n>` debe mapear a al menos un test.
- Nombre del test debe describir el comportamiento, no la implementación.

```python
# ✅ Correcto
def test_calculate_margin_returns_30_percent_for_valid_cost():
    result = calculate_margin(cost=100, margin_pct=30)
    assert result == 130

def test_calculate_margin_raises_error_for_negative_cost():
    with pytest.raises(ValueError, match="Cost must be positive"):
        calculate_margin(cost=-100, margin_pct=30)

# ❌ Incorrecto
def test_calculate_margin():
    assert calculate_margin(100, 30) == 130
```

## Tests de Integración

- Probar flujos completos: entrada → procesamiento → salida.
- Usar datos de prueba representativos.
- Limpiar estado entre tests (fixtures, temp files, rollback).

## Trazabilidad R<n> ↔ Test

Documentar en `progress/impl_<feature>.md`:

```markdown
## Trazabilidad

| Requisito | Test | Ubicación | Estado |
|---|---|---|---|
| R1: Validar campos obligatorios | test_validate_required_fields | tests/test_domain/test_services.py | ✅ Pass |
| R2: Calcular costo con 30% margen | test_calculate_margin_30_pct | tests/test_domain/test_services.py | ✅ Pass |
| R3: Exportar a Excel | test_export_excel_format | tests/test_storage/test_persistence.py | ✅ Pass |
```

## Comandos de Verificación

### Python
```bash
# Tests
pytest -v

# Con cobertura
pytest --cov=src --cov-report=term-missing

# Linting
ruff check src/ tests/

# Type checking
mypy src/
```

### Verificación Manual
- [ ] Ejecutar `./init.sh` (si existe) y verificar que termina verde.
- [ ] Ejecutar tests y verificar que todos pasan.
- [ ] Revisar que no hay archivos huérfanos (creados pero no referenciados).
- [ ] Revisar que `feature_list.json` está actualizado.

## Criterios de Aceptación de Revisión

El reviewer (rol del agente) debe verificar:

1. **Trazabilidad**: ¿Cada `R<n>` tiene test? ¿El test prueba lo que dice el requisito?
2. **Cobertura**: ¿Todos los caminos del `design.md` están probados?
3. **Convenciones**: ¿El código sigue `docs/conventions.md`?
4. **Documentación**: ¿Los docs están actualizados si la feature cambia algo?
5. **Estado**: ¿`feature_list.json` refleja la realidad?
