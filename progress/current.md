# progress/current.md — Sesión Activa

> Plan vivo de la sesión actual. Se actualiza en tiempo real.

## Sesión

- **Inicio**: [YYYY-MM-DD HH:MM]
- **Feature**: [ID de la feature en trabajo]
- **Fase actual**: [spec_author / waiting_approval / implementer / reviewer / done]
- **Agente**: Single Agent (roles: spec_author → implementer → reviewer)

## Plan de la Sesión

### Fase 1: Spec (spec_author)
- [ ] Leer `feature_list.json` y confirmar feature `pending`.
- [ ] Crear `specs/<feature-id>/requirements.md` (EARS).
- [ ] Crear `specs/<feature-id>/design.md` (decisiones técnicas).
- [ ] Crear `specs/<feature-id>/tasks.md` (checklist).
- [ ] Actualizar `feature_list.json` a `spec_ready`.
- [ ] **PAUSA**: Presentar spec al usuario y esperar "aprobado".

### Fase 2: Implementación (implementer)
- [ ] Esperar aprobación explícita del usuario.
- [ ] Actualizar `feature_list.json` a `in_progress`.
- [ ] Ejecutar tasks de `tasks.md` una a una, marcando `[x]`.
- [ ] Escribir tests para cada `R<n>`.
- [ ] Ejecutar tests y confirmar que pasan.
- [ ] Documentar en `progress/impl_<feature>.md`.

### Fase 3: Revisión (reviewer)
- [ ] Verificar trazabilidad `R<n> ↔ test`.
- [ ] Verificar cobertura de caminos del `design.md`.
- [ ] Verificar convenciones de código.
- [ ] Verificar documentación actualizada.
- [ ] Escribir `progress/review_<feature>.md`.
- [ ] Actualizar `feature_list.json` a `done`.

### Fase 4: Entrega
- [ ] Actualizar `progress/history.md` (append-only).
- [ ] Preparar ZIP con todo el repo.
- [ ] Informar al usuario de entrega.

## Estado Actual

- **Última acción**: [Qué se hizo recientemente]
- **Próxima acción**: [Qué viene ahora]
- **Bloqueos**: [Si hay algo que impide continuar]
- **Notas**: [Cualquier observación relevante]
