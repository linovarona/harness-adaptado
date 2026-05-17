# Design: {feature_name}

> **Feature:** {feature_id}
> **Fecha:** {date}
> **Autor:** spec_author
> Decisiones técnicas tomadas ANTES de escribir código.

---

## Decisiones Técnicas

### D1: [Título de la decisión principal]

**Elegido**: [Opción A — descripción]
**Impacto**: [Qué partes del sistema cambian]
**Justificación**:
[Explicación detallada de por qué A es mejor en este contexto específico.
Incluir trade-offs considerados.]

### D2: [Segunda decisión técnica]

**Elegido**: [Opción]
**Impacto**: [Qué partes cambian]
**Justificación**:
[Justificación]

---

## Alternativa descartada (obligatorio)

### A1: [Alternativa considerada]

**Descripción**: [Qué se consideró]
**Por qué se descartó**: [Análisis de pros/contras]
**Cuándo reconsiderar**: [Bajo qué condiciones vuelve a ser viable]

---

## Diagrama / Pseudocódigo

```
[Si aplica, incluir diagrama ASCII o pseudocódigo del flujo]

Ejemplo:
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Input     │────►│  Validate   │────►│  Process    │
│  (datos)    │     │  (R1, R2)   │     │  (lógica)   │
└─────────────┘     └─────────────┘     └──────┬──────┘
                                               │
                                               ▼
                                        ┌─────────────┐
                                        │   Output    │
                                        │  (result)   │
                                        └─────────────┘
```

---

## Dependencias

| Dependencia | Tipo | Estado |
|---|---|---|
| `src/storage.py` | Existente | Estable |
| `src/config.py` | Nuevo | A crear en esta feature |
| Librería X | Externa | Pendiente de evaluación |

---

## Riesgos

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| [Riesgo 1] | Alta/Media/Baja | Alto/Medio/Bajo | [Cómo mitigarlo] |
| [Riesgo 2] | Alta/Media/Baja | Alto/Medio/Bajo | [Cómo mitigarlo] |

---

## Notas de Implementación

- [Nota técnica relevante para el implementer]
- [Restricción o consideración especial]
