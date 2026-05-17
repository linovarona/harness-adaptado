# AGENTS.md — Mapa de Navegación para el Agente

> **Divulgación progresiva**: este archivo es tu punto de entrada. No leas todo de golpe. Sigue las referencias bajo demanda.

## Tu Rol

Eres un **agente único** que ejecuta secuencialmente los roles de:
1. **Spec Author** — Escribes requisitos, diseño y tareas
2. **Implementer** — Ejecutas el código siguiendo las tareas
3. **Reviewer** — Verificas trazabilidad y calidad

## Reglas de Oro

- **Una feature a la vez**: `feature_list.json` debe tener exactamente UNA feature en estado `pending` o `in_progress`.
- **Aprobación humana antes de código**: Nunca implementes sin que el usuario diga explícitamente "aprobado" o "continúa".
- **Estado en disco**: Todo lo que produces debe vivir en archivos, no solo en el chat.
- **Trazabilidad obligatoria**: Cada `R<n>` debe mapear a al menos un test.
- **Bitácora append-only**: `progress/history.md` solo crece, nunca se edita el pasado.

## Flujo de Trabajo

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   1. SPEC       │ ──► │   2. PAUSA      │ ──► │   3. CODE       │
│   (Escribes     │     │   (Esperas      │     │   (Implementas  │
│    requirements,│     │    "aprobado")   │     │    siguiendo    │
│    design,      │     │                 │     │    tasks.md)    │
│    tasks)       │     │                 │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
                                                        │
                                                        ▼
                                               ┌─────────────────┐
                                               │   4. REVIEW     │
                                               │   (Verificas    │
                                               │    R<n>↔test,   │
                                               │    completas    │
                                               │    checklist)   │
                                               └─────────────────┘
                                                        │
                                                        ▼
                                               ┌─────────────────┐
                                               │   5. ENTREGA    │
                                               │   (ZIP +        │
                                               │    history.md   │
                                               │    append)      │
                                               └─────────────────┘
```


## Flujo Completo (con Refinamiento)

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ REFINAMIENTO│───►│    SPEC     │───►│     CODE    │───►│   REVIEW    │
│(Conversación│    │   (EARS)    │    │  (tasks.md) │    │ (R↔test)    │
│   → .json)  │    │  → 3 archivos│   │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
        │                  │                  │                  │
        ▼                  ▼                  ▼                  ▼
   Sin aprobación    Aprobación humana   Tests pasan      ZIP + history
   (contexto vivo)   (puerta formal)    (verificable)    (append-only)
```

### ¿Cuándo usar refinamiento?

| Situación | ¿Refinamiento? | ¿SDD directo? |
|-----------|---------------|---------------|
| HU nueva, incompleta, compleja | ✅ Sí | ❌ No |
| Nomencladores desconocidos | ✅ Sí | ❌ No |
| Datos reales irregulares | ✅ Sí | ❌ No |
| Bug fix con repro clara | ❌ No | ✅ Sí |
| Feature trivial | ❌ No | ✅ Sí |
| Spec ya escrita por humano | ❌ No | ✅ Sí |

### ¿Cómo detectar si hay refinamiento?

Si `feature_list.json` tiene campo `refinement`:
```json
{
  "features": [{
    "id": "DESGLOSE-EC-001",
    "refinement": "progress/refinement_DESGLOSE-EC-001.md"
  }]
}
```

→ **Leer ese archivo primero** antes de escribir specs.

## Referencias (bajo demanda)

| ¿Necesitas...? | Ve a... |
|---|---|
| Saber qué feature toca | [`feature_list.json`](feature_list.json) |
| Entender el proceso SDD | [`docs/specs.md`](docs/specs.md) |
| Saber qué es "buen trabajo" | [`docs/architecture.md`](docs/architecture.md) |
| Convenciones de código | [`docs/conventions.md`](docs/conventions.md) |
| Cómo verificar que funciona | [`docs/verification.md`](docs/verification.md) |
| Criterios de "estado final correcto" | [`CHECKPOINTS.md`](CHECKPOINTS.md) |
| Ver estado de la sesión actual | [`progress/current.md`](progress/current.md) |
| Ver historial de sesiones | [`progress/history.md`](progress/history.md) |

## Estados de Feature

```
pending ──► spec_ready ──► in_progress ──► done
            ▲                              │
            └────── "aprobado" ────────────┘
```

- `pending`: Aún no tiene spec. Tu trabajo: crear `specs/<feature>/`.
- `spec_ready`: Spec escrito, esperando aprobación humana. NO toques código.
- `in_progress`: Aprobada. Implementas siguiendo `tasks.md`.
- `done`: Implementada, revisada, tests pasan. Actualizas `feature_list.json`.

## Anti-Patrones Prohibidos

- ❌ Implementar sin aprobación humana explícita.
- ❌ Tener más de una feature `in_progress` o `spec_ready`.
- ❌ Borrar o editar `progress/history.md` (solo append).
- ❌ Dejar un `R<n>` sin test que lo verifique.
- ❌ Saltarse el `design.md` y escribir código directo.
- ❌ No actualizar `feature_list.json` al cambiar de estado.
