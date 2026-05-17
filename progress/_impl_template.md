# progress/impl_{feature_id}.md — Implementación

> **Feature:** {feature_name}
> **Fecha:** {date}
> **Autor:** implementer

---

## Archivos tocados

| Archivo | Acción | Líneas +/- |
|---|---|---|
| `src/xxx.py` | Creado / Modificado | +50 / -10 |
| `tests/test_xxx.py` | Creado | +80 |
| `docs/xxx.md` | Modificado | +5 |

---

## Mapa de trazabilidad R<n> → Test

| Requirement | Test(s) que lo demuestran | Estado |
|---|---|---|
| R1 | `tests/test_xxx.py::test_...` | ✅ |
| R2 | `tests/test_xxx.py::test_...` | ✅ |
| R3 | `tests/test_xxx.py::test_...` | ✅ |

---

## Output de tests

```
$ pytest tests/ -v
======================== test session starts ========================
...
======================== N passed in X.XXs ========================
```

---

## Decisiones tomadas durante implementación

- _cualquier desviación del design.md y por qué_

---

## Deuda técnica / TODOs

- [ ] _item pendiente_
- [ ] _otro item_

