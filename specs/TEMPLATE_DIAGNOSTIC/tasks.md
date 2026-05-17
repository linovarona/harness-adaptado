# Tasks: [Nombre del Diagnóstico]

> **Feature:** [ID del diagnóstico]
> **Fecha:** [YYYY-MM-DD]
> **Autor:** spec_author / implementer
> **Tipo:** Diagnóstico (no modifica código)

---

## Preparación
- [ ] **T0.1** — Leer `requirements.md` y entender todos los R<n>
- [ ] **T0.2** — Leer `design.md` y entender decisiones D<n>
- [ ] **T0.3** — Revisar memoria previa del proyecto (si existe)
- [ ] **T0.4** — Intentar acceder al repositorio/código fuente

## Investigación del síntoma
- [ ] **T1** — Documentar síntoma con precisión (qué pasa, cuándo, dónde)
  - Cubre: R1
  - Archivos: `progress/impl_[id].md`

- [ ] **T2** — Listar hipótesis ordenadas por probabilidad
  - Cubre: R1
  - Formato: H1 (Alta), H2 (Alta), H3 (Media), H4 (Baja)
  - Archivos: `progress/impl_[id].md`

## Análisis de código/configuración
- [ ] **T3** — Si repo accesible: analizar archivos relevantes
  - Cubre: R3
  - Buscar: funciones de init, paths, permisos, configs
  - Archivos: Código fuente, `.json`, `.ps1`, `.sh`

- [ ] **T4** — Si repo NO accesible: análisis por patrones del ecosistema
  - Cubre: R3
  - Documentar: patrones conocidos, confianza de cada hallazgo
  - Archivos: `progress/impl_[id].md`

## Verificación de hipótesis
- [ ] **T5** — Verificar H1 con evidencia concreta
  - Cubre: R2
  - Estado: CONFIRMED / DISCARDED / TO_VERIFY
  - Archivos: `progress/impl_[id].md`

- [ ] **T6** — Verificar H2 con evidencia concreta
  - Cubre: R2
  - Estado: CONFIRMED / DISCARDED / TO_VERIFY
  - Archivos: `progress/impl_[id].md`

- [ ] **T7** — Verificar H3+ con evidencia concreta
  - Cubre: R2
  - Estado: CONFIRMED / DISCARDED / TO_VERIFY
  - Archivos: `progress/impl_[id].md`

## Script de diagnóstico (si aplica)
- [ ] **T8** — Crear script ejecutable (`diagnose-[sintoma].ps1/sh`)
  - Cubre: R4
  - Funciones: verificar pasos, reportar estado
  - Archivos: `scripts/diagnose-[sintoma].ps1`

- [ ] **T9** — Ejecutar script y verificar reporte
  - Cubre: R4, NF2, NF3
  - Output: `diagnostic-report.json`
  - Archivos: `scripts/diagnose-[sintoma].ps1`

## Documentación de hallazgos
- [ ] **T10** — Identificar causas raíz (no síntomas)
  - Cubre: R5
  - Formato: RC-1 (CRITICAL), RC-2 (HIGH), etc.
  - Archivos: `progress/impl_[id].md`

- [ ] **T11** — Proponer features de solución con IDs
  - Cubre: R5
  - Ejemplo: FIX-002, FIX-003, REFACT-001
  - Archivos: `progress/impl_[id].md`, `feature_list.json`

## Revisión
- [ ] **T12** — Escribir `progress/review_[id].md` con checklist
  - Cubre: CHECKPOINTS.md
  - Archivos: `progress/review_[id].md`

## Cierre
- [ ] **T13** — Actualizar `feature_list.json` → `status: "done"`
- [ ] **T14** — Actualizar `progress/history.md` con resumen
- [ ] **T15** — Si se proponen fixes, añadirlos a `feature_list.json` como `pending`

---

## Registro de progreso

| Task | Fecha inicio | Fecha fin | Notas |
|---|---|---|---|
| T0.1 | | | |
| T0.2 | | | |
| T0.3 | | | |
| T0.4 | | | |
| T1 | | | |
| T2 | | | |
| T3 | | | |
| T4 | | | |
| T5 | | | |
| T6 | | | |
| T7 | | | |
| T8 | | | |
| T9 | | | |
| T10 | | | |
| T11 | | | |
| T12 | | | |
| T13 | | | |
| T14 | | | |
| T15 | | | |
