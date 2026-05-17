# Requirements: FIX-001 — Diagnóstico BD SQLite no se crea

> **Feature:** FIX-001
> **Fecha:** 2026-05-16
> **Autor:** spec_author
> **Tipo:** Diagnóstico (no modifica código, solo investiga)

---

## R1: Trazabilidad completa del proceso de instalación

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall documentar cada paso del proceso de instalación desde Bundle WiX hasta arranque del servicio.

**Justificación**:
Sin trazabilidad no se puede identificar en qué paso falla la creación de BD.

**Criterio de aceptación**:
Dado que el instalador WiX Bundle se ejecuta,
Cuando finaliza la instalación,
Entonces existe un log que muestra: ejecución de pre-install, install, post-install, y arranque del servicio.

**Trazabilidad**:
- Test: `test_installation_traceability` (verificar que logs existen)
- Archivos: `scripts/pre-install.ps1`, `scripts/install.ps1`, `scripts/post-install.ps1`

---

## R2: Verificación de permisos de escritura

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall verificar y reportar permisos de lectura/escritura en la carpeta Data/ donde se espera la BD.

**Justificación**:
Windows Service corre bajo cuenta SYSTEM o usuario específico; permisos incorrectos son causa común de fallo silencioso.

**Criterio de aceptación**:
Dado que el servicio está instalado,
Cuando se ejecuta el script de diagnóstico,
Entonces reporta: usuario que ejecuta el servicio, ACLs de Data/, y si tiene permiso de escritura.

**Trazabilidad**:
- Test: `test_data_folder_permissions`
- Archivos: `diagnose-db.ps1`

---

## R3: Verificación de inicialización de DbContext

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall verificar si el código ejecuta `EnsureCreated()` o aplicación de migraciones en el ambiente Production.

**Justificación**:
En .NET es común que `EnsureCreated()` solo se ejecute en Development, dejando Production sin BD.

**Criterio de aceptación**:
Dado que se examina el código fuente,
Cuando se busca `EnsureCreated` o `Migrate`,
Entonces se reporta: dónde se llama, bajo qué condición (if Development?), y si falta en Production.

**Trazabilidad**:
- Test: `test_dbcontext_initialization_check`
- Archivos: `src/FichaCosto.Service/Program.cs`, `src/FichaCosto.Service/Data/AppDbContext.cs`

---

## R4: Verificación de path de SQLite

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall reportar la ruta absoluta donde el código intenta crear la base de datos SQLite.

**Justificación**:
La BD puede crearse en un path inesperado (ej. directorio del servicio vs. directorio de datos).

**Criterio de aceptación**:
Dado que se examina la configuración de DbContext,
Cuando se busca la connection string,
Entonces se reporta: ruta absoluta esperada, y si existe un archivo .db en esa ubicación.

**Trazabilidad**:
- Test: `test_sqlite_path_verification`
- Archivos: `src/FichaCosto.Service/appsettings.Production.json`, `src/FichaCosto.Service/Data/AppDbContext.cs`

---

## R5: Script de diagnóstico ejecutable

**Tipo**: Obligatorio
**Clase EARS**: Ubiquitous

**Descripción**:
The system shall incluir un script `diagnose-db.ps1` que ejecute todas las verificaciones anteriores y genere un reporte consolidado.

**Justificación**:
Un script único permite reproducir el diagnóstico en cualquier máquina sin intervención del agente.

**Criterio de aceptación**:
Dado que se ejecuta `diagnose-db.ps1` como Administrador,
Cuando finaliza,
Entonces genera `diagnostic-report.json` con: estado de cada verificación, hallazgos, y recomendaciones.

**Trazabilidad**:
- Test: `test_diagnose_script_execution`
- Archivos: `scripts/diagnose-db.ps1`

---

## Requisitos no-funcionales

| # | Requisito | Valor | Cómo verificar |
|---|---|---|---|
| NF1 | Seguridad | No exponer contraseñas ni datos sensibles en logs | Revisión manual del reporte |
| NF2 | Portabilidad | Script funciona en Windows 10/11 con PowerShell 5.1+ | Ejecutar en máquina limpia |

---

## Notas y supuestos

- Se asume acceso al código fuente del repositorio PDL-FC-MVP
- Se asume permisos de Administrador para ejecutar script de diagnóstico
- El diagnóstico no modifica código ni datos existentes
