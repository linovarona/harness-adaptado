# Requirements: [Nombre del Diagnóstico]

> **Feature:** [ID del diagnóstico]
> **Fecha:** [YYYY-MM-DD]
> **Autor:** spec_author
> **Tipo:** Diagnóstico (investiga, no modifica código)

---

## R1: Trazabilidad del sistema/síntoma

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall documentar el flujo completo desde entrada hasta fallo, identificando cada paso del proceso.

**Justificación**:
Sin trazabilidad no se puede localizar dónde ocurre el fallo.

**Criterio de aceptación**:
Dado que se describe el síntoma,
Cuando se analiza el sistema,
Entonces existe un diagrama o lista de pasos que muestra el flujo completo.

**Trazabilidad**:
- Test: `test_traceability_completeness`
- Archivos: `docs/diagnostico.md`, `progress/impl_[id].md`

---

## R2: Verificación de hipótesis priorizadas

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall listar hipótesis ordenadas por probabilidad y verificar cada una con evidencia concreta.

**Justificación**:
Evitar diagnóstico por adivinación; cada hipótesis debe confirmarse o descartarse.

**Criterio de aceptación**:
Dado que se identifican N hipótesis,
Cuando se verifica cada una,
Entonces se reporta: CONFIRMED / DISCARDED / TO_VERIFY con evidencia.

**Trazabilidad**:
- Test: `test_hypothesis_verification`
- Archivos: `progress/impl_[id].md`

---

## R3: Análisis de código/configuración relevante

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall examinar archivos fuente, configuraciones, logs, y scripts relacionados con el síntoma.

**Justificación**:
El diagnóstico requiere inspección directa de artefactos técnicos.

**Criterio de aceptación**:
Dado que se identifican archivos relevantes,
Cuando se analizan,
Entonces se reportan hallazgos específicos con referencias a líneas/secciones.

**Trazabilidad**:
- Test: `test_code_analysis_completeness`
- Archivos: Código fuente, configuraciones, scripts

---

## R4: Script/herramienta de diagnóstico ejecutable

**Tipo**: Obligatorio (si aplica)
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall incluir un script o comando que reproduzca/verifique el síntoma en el entorno destino.

**Justificación**:
Permite reproducir el diagnóstico sin intervención del agente original.

**Criterio de aceptación**:
Dado que se ejecuta el script de diagnóstico,
Cuando finaliza,
Entonces genera un reporte machine-readable con estado de cada verificación.

**Trazabilidad**:
- Test: `test_diagnostic_script_execution`
- Archivos: `scripts/diagnose-[sintoma].ps1/sh`, `diagnostic-report.json`

---

## R5: Documentación de causas raíz y recomendaciones

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall identificar causas raíz (no síntomas) y proponer features de solución con IDs.

**Justificación**:
El diagnóstico debe terminar con un plan de acción, no solo un reporte.

**Criterio de aceptación**:
Dado que se completan las verificaciones,
Cuando se genera el reporte,
Entonces incluye: causas raíz con severidad, y features recomendadas (FIX-002, FIX-003, etc.).

**Trazabilidad**:
- Test: `test_root_cause_identification`
- Archivos: `progress/impl_[id].md`, `feature_list.json` (features sugeridas)

---

## Requisitos no-funcionales

| # | Requisito | Valor | Cómo verificar |
|---|---|---|---|
| NF1 | Seguridad | No exponer credenciales ni datos sensibles en logs/reportes | Revisión manual |
| NF2 | Idempotencia | Script de diagnóstico puede ejecutarse múltiples veces sin cambiar estado | Ejecutar 2 veces, comparar resultados |
| NF3 | Portabilidad | Script funciona en entorno destino (PowerShell 5.1+/Bash) | Ejecutar en máquina limpia |

---

## Notas y supuestos

- El diagnóstico no modifica código, configuración, ni datos existentes
- Se asume acceso al código fuente o al entorno donde ocurre el síntoma
- Si el repo es inaccesible, se usa análisis por patrones conocidos del ecosistema
