# docs/conventions.md — Convenciones de Código

> Estilo, nombres, manejo de errores y estructura de commits.

## Lenguaje y Estilo

- **Idioma**: Código y comentarios en inglés. Documentación de specs en español (según preferencia del equipo).
- **Longitud de línea**: Máximo 100 caracteres.
- **Indentación**: 4 espacios (no tabs).

## Nomenclatura

| Elemento | Convención | Ejemplo |
|---|---|---|
| Clases | PascalCase | `NoteManager`, `CostCalculator` |
| Funciones | snake_case | `calculate_margin()`, `export_to_excel()` |
| Variables | snake_case | `total_cost`, `is_valid` |
| Constantes | UPPER_SNAKE_CASE | `MAX_RETRIES`, `DEFAULT_MARGIN` |
| Módulos | snake_case | `storage.py`, `config.py` |
| Tests | `test_` + snake_case | `test_calculate_margin_with_zero_cost()` |
| Requisitos | `R` + número | `R1`, `R2`, `R3` |
| Decisiones | `D` + número | `D1`, `D2` |

## Manejo de Errores

- Usar excepciones propias del dominio cuando sea posible.
- Nunca silenciar errores (`except: pass`).
- Loggear el error antes de propagarlo.
- Mensajes de error en español para el usuario final.

```python
# ✅ Correcto
try:
    result = calculate_cost(data)
except InvalidDataError as e:
    logger.error(f"Datos inválidos en cálculo de costo: {e}")
    raise CostCalculationError(f"No se pudo calcular el costo: {e}") from e

# ❌ Incorrecto
try:
    result = calculate_cost(data)
except:
    pass
```

## Estructura de Archivos

```
src/
├── __init__.py
├── cli.py              ← Punto de entrada (argparse / click)
├── domain/
│   ├── __init__.py
│   ├── models.py       ← Dataclasses / Pydantic models
│   └── services.py     ← Lógica de negocio pura
├── storage/
│   ├── __init__.py
│   └── persistence.py  ← SQLite, JSON, Excel, etc.
└── utils/
    ├── __init__.py
    ├── config.py       ← Configuración y constantes
    └── logger.py       ← Setup de logging

tests/
├── __init__.py
├── test_domain/
│   ├── test_models.py
│   └── test_services.py
├── test_storage/
│   └── test_persistence.py
└── test_cli/
    └── test_cli.py
```

## Commits (si aplica control de versiones)

Formato: `[<tipo>] <descripción>`

| Tipo | Uso |
|---|---|
| `[SPEC]` | Cambios en specs (requirements, design, tasks) |
| `[IMPL]` | Implementación de código |
| `[TEST]` | Tests nuevos o modificados |
| `[FIX]` | Corrección de bugs |
| `[DOC]` | Documentación |
| `[REF]` | Refactorización |

Ejemplo: `[IMPL] Add cost calculation with 30% margin validation`

## Logging

- Usar `loguru` o `logging` estándar.
- Niveles: `DEBUG` (desarrollo), `INFO` (operación normal), `WARNING` (anomalías), `ERROR` (fallos).
- Incluir contexto: IDs, estados, valores relevantes.
- Nunca loggear información sensible (contraseñas, tokens, PII).
