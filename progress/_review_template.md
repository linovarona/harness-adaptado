# progress/review_{feature_id}.md — Revisión

> **Feature:** {feature_name}
> **Fecha:** {date}
> **Autor:** reviewer

---

## Checklist contra CHECKPOINTS.md

### Globales
- [ ] G1: `feature_list.json` estado correcto
- [ ] G2: `specs/{feature_id}/` existe con 3 archivos
- [ ] G3: Todos los R<n> tienen trazabilidad a test
- [ ] G4: Todos los tests pasan
- [ ] G5: No hay código sin cubrir por spec
- [ ] G6: `progress/impl_{feature_id}.md` documenta archivos
- [ ] G7: `progress/review_{feature_id}.md` existe (este archivo)

### Fase Spec
- [ ] S1: Requirements en EARS
- [ ] S2: Requirements numerados sin huecos
- [ ] S3: Design tiene alternativa descartada
- [ ] S4: Tasks atómicos
- [ ] S5: Tasks cubren todos los R<n>

### Fase Implementación
- [ ] I1: Tasks marcados progresivamente
- [ ] I2: Commits lógicos (si aplica)
- [ ] I3: Código sigue conventions.md
- [ ] I4: Tests pasan antes de seguir

### Fase Revisión
- [ ] V1: Mapa R<n> → test completo
- [ ] V2: No hay tests huérfanos
- [ ] V3: Coverage aceptable
- [ ] V4: Documentación actualizada

---

## Hallazgos

| # | Severidad | Descripción | Resolución |
|---|---|---|---|
| 1 | 🔴 Bloqueante | _descripción_ | _cómo se resolvió_ |
| 2 | 🟡 Advertencia | _descripción_ | _cómo se resolvió_ |
| 3 | 🟢 Sugerencia | _descripción_ | _para futuras sesiones_ |

---

## Veredicto

**Estado:** ✅ APROBADO / ❌ RECHAZADO (con correcciones)

**Condiciones para aprobación:** _si aplica, qué se necesita para aprobar_

**Recomendaciones:** _sugerencias para próximas features_

