# progress/history.md — Bitácora de Sesiones

> Append-only. Nunca editar entradas pasadas. Solo añadir al final.

## Formato de Entrada

```markdown
## [YYYY-MM-DD HH:MM] — [Feature ID] — [Estado final]

**Fase**: [Fase alcanzada: spec_ready / in_progress / done]
**Agente**: Single Agent
**Duración**: [Tiempo aproximado de la sesión]

### Resumen
[Breve descripción de qué se hizo en esta sesión.]

### Archivos generados/modificados
- `specs/[feature-id]/requirements.md`
- `specs/[feature-id]/design.md`
- `specs/[feature-id]/tasks.md`
- `src/...`
- `tests/...`
- `progress/impl_[feature-id].md`
- `progress/review_[feature-id].md`

### Trazabilidad
| Requisito | Test | Estado |
|---|---|---|
| R1 | test_... | ✅ Pass |
| R2 | test_... | ✅ Pass |

### Lecciones / Notas
- [Algo que aprendimos o que hay que recordar para la próxima vez]
- [Decisión que se tomó y por qué]

### Próximos pasos
- [Qué falta o qué viene después]
```

---

## Entradas

<!-- Añadir nuevas entradas aquí, al final -->
