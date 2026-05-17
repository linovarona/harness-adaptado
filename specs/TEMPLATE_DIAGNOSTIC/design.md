# Design: [Nombre del Diagnóstico]

> **Feature:** [ID del diagnóstico]
> **Fecha:** [YYYY-MM-DD]
> **Autor:** spec_author
> **Tipo:** Diagnóstico

---

## Decisiones Técnicas

### D1: Estrategia de investigación

**Elegido**: Análisis estático de código + verificación de entorno + scripts ejecutables
**Impacto**: Ninguno en runtime; solo lectura y reporte
**Justificación**:
- Mínima invasión: no toca código ni configuración
- Reproducible: scripts pueden ejecutarse en cualquier máquina
- No requiere reinstalación ni reinicio para diagnosticar

### D2: Manejo de repo inaccesible

**Elegido**: Análisis por patrones conocidos + contexto de memoria + verificación cuando sea posible
**Impacto**: Reporte con nivel de confianza (HIGH/MEDIUM/LOW)
**Justificación**:
- Cuando el repo no es accesible (red, privado, movido), se usan patrones del ecosistema
- Cada hallazgo se marca con confianza y verificación pendiente
- Cuando el repo sea accesible, se confirman/descartan hipótesis

---

## Alternativa descartada (obligatorio)

### A1: Modificar el sistema para debugging

**Descripción**: Añadir logs verbose, breakpoints, o instrumentación al código
**Por qué se descartó**:
- Mayor riesgo: toca código que podría estar en producción
- Más lento: requiere rebuild/redeploy
- Menos flexible: solo funciona en entorno controlado
**Cuándo reconsiderar**: Si el análisis estático no revela la causa y se necesita runtime debugging

---

## Diagrama del flujo de diagnóstico

```
┌─────────────────┐
│  Síntoma        │
│  reportado      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Listar         │
│  hipótesis      │
│  (probabilidad) │
└────────┬────────┘
         │
         ▼
┌─────────────────┐     ┌─────────────────┐
│  ¿Repo          │──NO─►│  Análisis por   │
│  accesible?     │      │  patrones       │
└────────┬────────┘      │  (confianza)    │
       YES             └─────────────────┘
         │                      │
         ▼                      ▼
┌─────────────────┐     ┌─────────────────┐
│  Análisis       │     │  Verificar      │
│  código fuente  │     │  hipótesis      │
│  (confirmar)    │     │  cuando sea     │
└─────────────────┘     │  posible        │
         │              └─────────────────┘
         ▼                      │
┌─────────────────┐             ▼
│  Verificar      │    ┌─────────────────┐
│  hipótesis      │    │  Reporte con    │
│  con evidencia  │    │  nivel de       │
└─────────────────┘    │  confianza      │
         │             └─────────────────┘
         ▼
┌─────────────────┐
│  Identificar    │
│  causas raíz    │
└─────────────────┘
         │
         ▼
┌─────────────────┐
│  Proponer       │
│  features de    │
│  solución       │
│  (FIX-002...)   │
└─────────────────┘
```

---

## Dependencias

| Dependencia | Tipo | Estado |
|---|---|---|
| Repositorio/código fuente | Externo | Variable (puede ser inaccesible) |
| Entorno donde ocurre síntoma | Externo | Requerido para scripts |
| PowerShell 5.1+ / Bash | Externo | Requerido para scripts ejecutables |
| Documentación/memoria previa | Interna | Usar si existe |

---

## Riesgos

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| Repo inaccesible | Media | Alto | Usar análisis por patrones + marcar confianza |
| Síntoma no reproducible | Media | Alto | Documentar condiciones exactas del entorno |
| Falta de logs/historial | Media | Medio | Solicitar logs al usuario o del sistema |
| Diagnóstico incompleto | Baja | Alto | Checklist estricto de R1-R5 |

---

## Notas de Implementación

- El diagnóstico debe ser **idempotente**: ejecutar múltiples veces no cambia nada
- El reporte debe ser **machine-readable** (JSON) para posible automatización
- Incluir **timestamps** en cada verificación
- Marcar cada hallazgo con **nivel de confianza**: CONFIRMED / HIGH / MEDIUM / LOW
- Cuando el repo sea accesible, actualizar el reporte con confirmaciones
