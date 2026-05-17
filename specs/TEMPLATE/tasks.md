# Tasks: {feature_name}

> **Feature:** {feature_id}
> **Fecha:** {date}
> **Autor:** spec_author / implementer
> Checklist discreto de implementación. Marcar `[x]` una a una.

---

## Preparación
- [ ] **T0.1** — Leer `requirements.md` y entender todos los `R<n>`.
- [ ] **T0.2** — Leer `design.md` y entender las decisiones `D<n>`.
- [ ] **T0.3** — Verificar que `CHECKPOINTS.md` está presente.
- [ ] **T0.4** — Confirmar que no hay otra feature `in_progress`.
- [ ] **T0.5** — Verificar que las dependencias listadas en `design.md` están disponibles.
- [ ] **T0.6** — Crear estructura de archivos necesaria (directorios, `__init__.py`).

## Implementación de Dominio
- [ ] **T1** — [Implementar modelo de datos para R1]
  - Cubre: `R1`
  - Archivos: `src/xxx.py`
  - Tests: `tests/test_xxx.py::test_...`

- [ ] **T2** — [Implementar lógica de negocio para R2]
  - Cubre: `R2`
  - Archivos: `src/xxx.py`
  - Tests: `tests/test_xxx.py::test_...`

- [ ] **T3** — [Implementar validaciones según R3]
  - Cubre: `R3`
  - Archivos: `src/xxx.py`
  - Tests: `tests/test_xxx.py::test_...`

## Implementación de Infraestructura
- [ ] **T4** — [Implementar persistencia/storage si aplica]
  - Cubre: `R...`
  - Archivos: `src/storage/xxx.py`
  - Tests: `tests/test_storage/test_xxx.py::test_...`

- [ ] **T5** — [Implementar interfaz CLI/API si aplica]
  - Cubre: `R...`
  - Archivos: `src/cli.py` / `src/api.py`
  - Tests: `tests/test_cli/test_xxx.py::test_...`

## Tests
- [ ] **T6** — Ejecutar test suite completo
  - `pytest` debe pasar al 100%
  - Documentar output en `progress/impl_{feature_id}.md`

- [ ] **T7** — Verificar trazabilidad R<n> ↔ test
  - Cada requirement tiene al menos un test
  - Documentar mapa en `progress/impl_{feature_id}.md`

## Verificación
- [ ] **T8** — Verificar cobertura de caminos del `design.md`
- [ ] **T9** — Verificar convenciones de código (`docs/conventions.md`)
- [ ] **T10** — Actualizar `progress/impl_{feature_id}.md` con archivos, trazabilidad, output de tests
- [ ] **T11** — Ejecutar revisión y escribir `progress/review_{feature_id}.md`
- [ ] **T12** — Actualizar `feature_list.json` a `done`
- [ ] **T13** — Actualizar `progress/history.md` con resumen de sesión

---

## Registro de progreso

| Task | Fecha inicio | Fecha fin | Notas |
|---|---|---|---|
| T0.1 | | | |
| T0.2 | | | |
| T1 | | | |
| T2 | | | |
| T3 | | | |
| T4 | | | |
| T5 | | | |
| T6 | | | |
| T7 | | | |
| T8 | | | |
| T9 | | | |
| T10 | | | |
| T11 | | | |
| T12 | | | |
| T13 | | | |
