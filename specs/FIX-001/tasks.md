# Tasks: FIX-001 — Diagnóstico BD SQLite

> **Feature:** FIX-001
> **Fecha:** 2026-05-16
> **Autor:** spec_author / implementer
> **Tipo:** Diagnóstico (no modifica código)

---

## Preparación
- [ ] **T0.1** — Leer `requirements.md` y entender todos los R<n>
- [ ] **T0.2** — Leer `design.md` y entender decisiones D<n>
- [ ] **T0.3** — Confirmar acceso al repositorio PDL-FC-MVP (https://github.com/linovarona/PDL-FC-MVP)
- [ ] **T0.4** — Clonar repositorio en entorno de trabajo

## Análisis de scripts de instalación
- [ ] **T1** — Leer `scripts/pre-install.ps1`
  - Cubre: R1
  - ¿Qué hace? ¿Menciona BD?
  - Archivos: `scripts/pre-install.ps1`

- [ ] **T2** — Leer `scripts/install.ps1`
  - Cubre: R1
  - ¿Qué hace? ¿Menciona BD?
  - Archivos: `scripts/install.ps1`

- [ ] **T3** — Leer `scripts/post-install.ps1`
  - Cubre: R1, R3
  - ¿Ejecuta init de BD? ¿Llama a dotnet ef? ¿EnsureCreated?
  - Archivos: `scripts/post-install.ps1`

## Análisis de código fuente
- [ ] **T4** — Leer `src/FichaCosto.Service/Program.cs`
  - Cubre: R3
  - Buscar: `EnsureCreated`, `Migrate`, `Development`, `Production`
  - Archivos: `src/FichaCosto.Service/Program.cs`

- [ ] **T5** — Leer `src/FichaCosto.Service/Data/AppDbContext.cs` (o similar)
  - Cubre: R3, R4
  - Buscar: connection string, path de SQLite, `OnConfiguring`
  - Archivos: `src/FichaCosto.Service/Data/*.cs`

- [ ] **T6** — Leer `src/FichaCosto.Service/appsettings.Production.json`
  - Cubre: R4
  - Buscar: `ConnectionStrings`, path de SQLite
  - Archivos: `src/FichaCosto.Service/appsettings*.json`

## Verificación de estructura
- [ ] **T7** — Verificar estructura de directorios post-instalación esperada
  - Cubre: R2, R4
  - ¿Existe carpeta `Data/`? ¿Dónde debería estar?
  - Archivos: `docs/PROCEDIMIENTO-FASE-01.md`, `docs/DOCUMENTACION_TECNICA.md`

## Creación de script de diagnóstico
- [ ] **T8** — Crear `scripts/diagnose-db.ps1`
  - Cubre: R5
  - Funciones:
    - `Test-InstallationTraceability`: verificar logs de instalación
    - `Test-DataFolderPermissions`: verificar ACLs de Data/
    - `Test-DbContextInitialization`: buscar EnsureCreated/Migrate
    - `Test-SqlitePath`: verificar connection string y path
  - Archivos: `scripts/diagnose-db.ps1`

- [ ] **T9** — Ejecutar `diagnose-db.ps1` y verificar que genera reporte
  - Cubre: R5, NF1, NF2
  - Output: `diagnostic-report.json`
  - Archivos: `scripts/diagnose-db.ps1`

## Documentación de hallazgos
- [ ] **T10** — Documentar hallazgos en `progress/impl_FIX-001.md`
  - Cubre: R1-R5
  - Incluir: archivos tocados, mapa R<n>→test, output del diagnóstico
  - Archivos: `progress/impl_FIX-001.md`

- [ ] **T11** — Escribir `progress/review_FIX-001.md` con checklist de revisión
  - Cubre: CHECKPOINTS.md
  - Archivos: `progress/review_FIX-001.md`

## Cierre
- [ ] **T12** — Actualizar `feature_list.json` → `status: "done"`
- [ ] **T13** — Actualizar `progress/history.md` con resumen de sesión

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
