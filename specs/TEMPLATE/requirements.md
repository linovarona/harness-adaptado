# Requirements: {feature_name}

> **Feature:** {feature_id}
> **Fecha:** {date}
> **Autor:** spec_author
> Requisitos en notación EARS. Cada requisito debe ser verificable.

---

## R1: [Título del requisito principal]

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The `<system>` shall `<capability>`.

**Justificación**:
[Contexto de negocio o técnico. Por qué existe este requisito.]

**Criterio de aceptación**:
Dado que [estado inicial],
Cuando [acción del usuario o evento],
Entonces [resultado esperado observable].

**Trazabilidad**:
- Test: `tests/test_xxx.py::test_...`
- Archivos: `src/xxx.py`

---

## R2: [Título del segundo requisito]

**Tipo**: Obligatorio
**Clase EARS**: Event-driven

**Descripción**:
When `<trigger>`, the `<system>` shall `<capability>`.

**Justificación**:
[Contexto]

**Criterio de aceptación**:
Dado que [estado inicial],
Cuando [acción],
Entonces [resultado].

**Trazabilidad**:
- Test: `tests/test_xxx.py::test_...`
- Archivos: `src/xxx.py`

---

## R3: [Título del tercer requisito]

**Tipo**: Deseable
**Clase EARS**: State-driven

**Descripción**:
While `<condition>`, the `<system>` shall `<capability>`.

**Justificación**:
[Contexto]

**Criterio de aceptación**:
[Given-When-Then]

**Trazabilidad**:
- Test: `tests/test_xxx.py::test_...`
- Archivos: `src/xxx.py`

---

## Requisitos no-funcionales (si aplica)

| # | Requisito | Valor | Cómo verificar |
|---|---|---|---|
| NF1 | Performance | < 100ms por operación | Benchmark en test |
| NF2 | Seguridad | Sin datos sensibles en logs | Revisión manual |

---

## Notas y supuestos

- _Supuesto 1: ..._
- _Dependencia: requiere feature X completada_
- _Restricción: no se puede usar librería Y por licencia_
