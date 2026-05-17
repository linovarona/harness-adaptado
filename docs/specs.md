# docs/specs.md — Spec Driven Development (SDD)

> Proceso de desarrollo guiado por especificaciones. Cada feature pasa por 3 archivos antes de tocar código.

## Los 3 Archivos de una Spec

### 1. `requirements.md` — Qué debe hacer

- Notación **EARS** (Easy Approach to Requirements Syntax).
- Cada requisito numerado: `R1`, `R2`, `R3`...
- Debe ser verificable: ¿cómo probarías que se cumple?

#### Plantilla EARS

```markdown
## R<n>: [Título del requisito]

**Tipo**: [Obligatorio / Deseable / Opcional]

**Descripción**:
El sistema [debe/shall] [acción] [condición] [resultado esperado].

**Justificación**:
[Por qué este requisito existe. Contexto de negocio o técnico.]

**Criterio de aceptación**:
[Dado que... Cuando... Entonces...]

**Trazabilidad**:
- Test: [nombre del test que verifica esto]
- Ubicación: [ruta del archivo de test]
```

#### Tipos de Requisitos EARS

| Prefijo | Uso | Ejemplo |
|---|---|---|
| `The system shall...` | Funcionalidad obligatoria | `The system shall validate that all required fields are present.` |
| `When [event] the system shall...` | Reactivo | `When the user submits the form, the system shall save the data.` |
| `While [condition] the system shall...` | Continuo | `While the service is running, the system shall log all requests.` |
| `Where [feature] the system shall...` | Localizado | `Where the export format is CSV, the system shall include headers.` |

### 2. `design.md` — Cómo lo hará

- Decisiones técnicas **antes** de escribir código.
- Alternativa considerada y **descartada**, con justificación.
- Diagramas o pseudocódigo si aplica.

#### Estructura

```markdown
# Design: [Nombre de la feature]

## Decisiones Técnicas

### D1: [Título de decisión]
**Elegido**: [Opción A]
**Alternativa descartada**: [Opción B]
**Justificación**: [Por qué A es mejor que B en este contexto]

## Diagrama / Pseudocódigo

[Si aplica, incluir diagrama ASCII o pseudocódigo]

## Dependencias

- [Lista de dependencias externas o internas]

## Riesgos

- [Riesgo identificado] → [Mitigación]
```

### 3. `tasks.md` — Checklist de implementación

- Lista discreta, ordenada, ejecutable paso a paso.
- El implementer las marca `[x]` una a una.
- Cada task debe ser lo suficientemente pequeña para caber en un context window.

#### Estructura

```markdown
# Tasks: [Nombre de la feature]

## Preparación
- [ ] [Task 1: acción concreta]
- [ ] [Task 2: acción concreta]

## Implementación
- [ ] [Task 3: acción concreta]
- [ ] [Task 4: acción concreta]

## Tests
- [ ] [Task 5: escribir test para R1]
- [ ] [Task 6: escribir test para R2]

## Verificación
- [ ] [Task 7: ejecutar todos los tests]
- [ ] [Task 8: verificar trazabilidad R<n> ↔ test]
```

## Puerta de Aprobación Humana

El agente **debe detenerse** después de escribir los 3 archivos y **esperar aprobación explícita**.

Mensaje al usuario:

> "Spec completa para `[feature-id]`. Por favor revisa:
> - `specs/[feature-id]/requirements.md` — requisitos EARS
> - `specs/[feature-id]/design.md` — decisiones técnicas
> - `specs/[feature-id]/tasks.md` — plan de implementación
>
> Di 'aprobado' para continuar, o solicita cambios."

## Estados de la Spec

| Estado | Significado | Quién actúa |
|---|---|---|
| `pending` | Sin spec escrita | Agente (spec_author) |
| `spec_ready` | Spec escrita, esperando aprobación | Usuario |
| `in_progress` | Aprobada, en implementación | Agente (implementer) |
| `done` | Implementada y revisada | Agente (reviewer) |
