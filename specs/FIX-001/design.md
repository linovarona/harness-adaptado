# Design: FIX-001 — Diagnóstico BD SQLite

> **Feature:** FIX-001
> **Fecha:** 2026-05-16
> **Autor:** spec_author
> **Tipo:** Diagnóstico

---

## Decisiones Técnicas

### D1: Enfoque de diagnóstico

**Elegido**: Script PowerShell independiente + análisis estático de código
**Impacto**: Ninguno en runtime; solo lectura y reporte
**Justificación**:
- Mínima invasión: no toca instalador ni servicio
- Reproducible: cualquiera puede ejecutar `diagnose-db.ps1`
- No requiere reinstalación para diagnosticar

### D2: Estrategia de análisis de código

**Elegido**: Leer archivos fuente directamente (Program.cs, DbContext.cs, scripts .ps1)
**Impacto**: Ninguno; solo lectura
**Justificación**:
- No necesita compilar ni ejecutar el servicio
- Permite verificar código sin depender de estado de máquina destino

---

## Alternativa descartada (obligatorio)

### A1: Modificar el instalador WiX para debugging

**Descripción**: Añadir ventanas de debug o logs verbose al instalador WiX
**Por qué se descartó**:
- Mayor riesgo: toca el instalador que ya funciona
- Más lento: requiere rebuild del Bundle
- Menos flexible: solo se ejecuta durante instalación, no post-mortem
**Cuándo reconsiderar**: Si el diagnóstico revela que el fallo está en el propio WiX (no en el código ni scripts)

---

## Diagrama del flujo de diagnóstico

```
┌─────────────────┐
│  Clonar repo    │
│  PDL-FC-MVP     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐     ┌─────────────────┐
│  Analizar       │────►│  Verificar      │
│  scripts/       │     │  post-install   │
│  *.ps1          │     │  ejecuta init   │
└─────────────────┘     └─────────────────┘
         │
         ▼
┌─────────────────┐     ┌─────────────────┐
│  Analizar       │────►│  Verificar      │
│  Program.cs     │     │  EnsureCreated  │
│  DbContext.cs   │     │  en Production  │
└─────────────────┘     └─────────────────┘
         │
         ▼
┌─────────────────┐     ┌─────────────────┐
│  Verificar      │────►│  Verificar      │
│  appsettings.*  │     │  path SQLite    │
│  connection str │     │  es correcto    │
└─────────────────┘     └─────────────────┘
         │
         ▼
┌─────────────────┐
│  Generar        │
│  diagnostic-    │
│  report.json    │
└─────────────────┘
```

---

## Dependencias

| Dependencia | Tipo | Estado |
|---|---|---|
| Repositorio PDL-FC-MVP | Externo | Público (GitHub) |
| PowerShell 5.1+ | Externo | Requerido en máquina destino |
| Git | Externo | Para clonar repo |

---

## Riesgos

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| Repo privado o movido | Baja | Alto | Verificar acceso antes de empezar |
| Código cambió desde instalador | Media | Medio | Especificar commit/hash en diagnóstico |
| Script no tiene permisos en máquina destino | Media | Medio | Documentar requisito de Admin |

---

## Notas de Implementación

- El diagnóstico debe ser **idempotente**: ejecutar múltiples veces no cambia nada
- El reporte debe ser **machine-readable** (JSON) para posible automatización futura
- Incluir **timestamps** en cada verificación para correlación con logs del sistema
