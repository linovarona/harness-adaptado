# docs/architecture.md — Definición de "Buen Trabajo"

> Principios arquitectónicos que guían todas las decisiones técnicas del proyecto.

## Principios Fundamentales

### 1. Simplicidad Intencional
- Preferir lo simple sobre lo complejo.
- "No es simple si no se puede explicar en una oración."
- Cada capa de abstracción debe justificar su existencia.

### 2. Estado en Disco
- La verdad vive en los archivos, no en la memoria del agente ni en el chat.
- Todo artefacto debe ser serializable y versionable.
- `progress/history.md` es append-only: el pasado no se edita.

### 3. Trazabilidad Total
- Cada requisito `R<n>` debe ser rastreable hasta un test concreto.
- Cada decisión `D<n>` debe ser rastreable hasta código concreto.
- Si no se puede probar, no se puede afirmar que existe.

### 4. Aprobación Humana como Puerta
- El humano es el único que puede aprobar specs.
- El agente propone, el humano dispone.
- Nunca "asumir" aprobación: esperar explícita.

### 5. Un Paso a la Vez
- Una feature a la vez.
- Una fase a la vez.
- Un task a la vez.

## Capas del Sistema

```
┌─────────────────────────────────────┐
│  CLI / API / Interface              │  ← Punto de entrada
├─────────────────────────────────────┤
│  Domain / Business Logic            │  ← Reglas de negocio
├─────────────────────────────────────┤
│  Storage / Persistence              │  ← Datos, archivos, BD
├─────────────────────────────────────┤
│  Infrastructure / Utils             │  ← Logging, config, helpers
└─────────────────────────────────────┘
```

## Reglas de Dependencia

- Las capas superiores pueden depender de las inferiores.
- Las capas inferiores **NUNCA** dependen de las superiores.
- Los tests de una capa pueden mockear las capas inferiores.
- No compartir estado mutable entre capas.

## Definición de "Done"

Una feature está "done" cuando:

1. ✅ Spec aprobada por humano (estado `spec_ready` → `in_progress`).
2. ✅ Todos los tasks en `tasks.md` marcados `[x]`.
3. ✅ Todos los tests pasan.
4. ✅ Trazabilidad `R<n> → test` documentada.
5. ✅ Revisión completada (`progress/review_<feature>.md`).
6. ✅ `feature_list.json` actualizado a `done`.
7. ✅ `progress/history.md` actualizado con resumen.
8. ✅ Código listo para entrega (ZIP).
