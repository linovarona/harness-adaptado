# CHECKPOINTS.md — Criterios de Estado Final Correcto

> Checklist por fase. El agente debe verificar cada ítem antes de considerar una fase completada.

## CHECKPOINT: Refinamiento Completo (opcional)

> Solo si la feature requiere descubrimiento de reglas de negocio. Omitir para features triviales o specs ya escritas.

- [ ] Historia de usuario capturada en lenguaje natural
- [ ] Asunciones listadas y numeradas (técnicas + no-técnicas)
- [ ] Usuario validó/rechazó asunciones
- [ ] Preguntas iterativas completadas con barra de progreso
- [ ] `feature_list.json` generado con contexto enriquecido
- [ ] `progress/refinement_<feature_id>.md` documentado con:
  - Historia original
  - Asunciones rechazadas
  - Preguntas/respuestas
  - Nomencladores identificados
  - Datos reales analizados
  - Reglas de negocio consolidadas
- [ ] Feature marcada como lista para SDD (estado `pending`)

---

## CHECKPOINT: Spec Completa

- [ ] `feature_list.json` tiene exactamente UNA feature en `pending` (la que vas a trabajar).
- [ ] Existe directorio `specs/<feature-id>/`.
- [ ] `requirements.md` existe y contiene requisitos numerados `R1`, `R2`, ... en notación EARS.
- [ ] `design.md` existe y contiene: decisiones técnicas, alternativa descartada con justificación.
- [ ] `tasks.md` existe y es un checklist discreto, ejecutable paso a paso.
- [ ] Todos los requisitos en `requirements.md` son verificables (no vagos).
- [ ] `feature_list.json` actualizado a `spec_ready`.
- [ ] **PAUSA**: Informar al usuario que la spec está lista para revisión.

## CHECKPOINT: Aprobación Humana

- [ ] Usuario ha dicho explícitamente "aprobado", "continúa", "adelante", o similar.
- [ ] Si el usuario pidió cambios: spec modificada y re-presentada.
- [ ] `feature_list.json` actualizado a `in_progress`.

## CHECKPOINT: Implementación Completa

- [ ] Todas las tareas en `tasks.md` están marcadas `[x]`.
- [ ] Código escrito siguiendo `docs/conventions.md`.
- [ ] Tests escritos y pasando.
- [ ] Mapa de trazabilidad `R<n> → test` documentado en `progress/impl_<feature>.md`.
- [ ] `progress/impl_<feature>.md` contiene: archivos tocados, mapa R→test, output de tests.
- [ ] `progress/current.md` actualizado con estado de la sesión.

## CHECKPOINT: Revisión Completa

- [ ] Revisión de trazabilidad: cada `R<n>` tiene al menos un test.
- [ ] Revisión de cobertura: todos los caminos críticos del diseño están probados.
- [ ] Revisión de convenciones: nombres, estilo, estructura coinciden con `docs/conventions.md`.
- [ ] Revisión de documentación: `docs/` actualizados si la feature cambia la arquitectura.
- [ ] `progress/review_<feature>.md` escrito con checklist de revisión.
- [ ] `feature_list.json` actualizado a `done`.

## CHECKPOINT: Entrega Final

- [ ] Todos los tests pasan (comando ejecutado, output incluido en `progress/impl_<feature>.md`).
- [ ] `progress/history.md` actualizado con resumen append-only de la sesión.
- [ ] Archivos listos para ZIP: todo el repo en estado consistente.
- [ ] Usuario informado de entrega y próximos pasos.
