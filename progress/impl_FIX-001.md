# Implementación: FIX-001 — Diagnóstico BD SQLite no se crea al finalizar instalación

**Fecha:** 2026-05-16  
**Feature:** FIX-001  
**Estado:** Implementado  

## Resumen del problema

La base de datos SQLite no se creaba al finalizar la instalación porque los archivos `Schema.sql` y `SeedData.sql` no se copiaban al directorio `C:\ProgramData\FichaCostoService\Data\`, donde la aplicación los espera encontrar.

## Causa raíz identificada

El instalador WiX configuraba correctamente el directorio `DATADB` en `CommonAppDataFolder`, pero los archivos SQL solo se instalaban allí sin un mecanismo explícito que garantizara su presencia antes de que la aplicación intentara inicializar la base de datos.

## Solución implementada

### 1. Modificación de `post-install.ps1`

Se actualizó el script de post-instalación para:

- Copiar explícitamente `Schema.sql` y `SeedData.sql` desde el directorio de instalación (`C:\Program Files\FichaCostoService\Data`) hacia `C:\ProgramData\FichaCostoService\Data`
- Crear el directorio de destino si no existe
- Configurar permisos adecuados para `NT AUTHORITY\SYSTEM` y `BUILTIN\Administrators`
- Registrar todas las operaciones en logs

**Archivo modificado:** `/src/FichaCosto.Installer/post-install.ps1`

### 2. Adición de componente WiX `CopyFile`

Se agregaron componentes WiX que utilizan el elemento `CopyFile` para copiar automáticamente los archivos SQL durante la instalación:

```xml
<ComponentGroup Id="SqlCopyComponents" Directory="INSTALLFOLDER">
  <Component Id="CopySchemaToProgramData" Guid="A1B2C3D4-E5F6-7890-ABCD-EF1234567890">
    <File Id="CopySchema" Source="$(var.PublishDir)\Data\Schema.sql" Vital="yes" />
    <CopyFile On="install" DestinationDirectory="DATADB" DestinationName="Schema.sql" />
  </Component>
  <Component Id="CopySeedDataToProgramData" Guid="B2C3D4E5-F6A7-8901-BCDE-F12345678901">
    <File Id="CopySeedData" Source="$(var.PublishDir)\Data\SeedData.sql" Vital="yes" />
    <CopyFile On="install" DestinationDirectory="DATADB" DestinationName="SeedData.sql" />
  </Component>
</ComponentGroup>
```

**Archivo modificado:** `/src/FichaCosto.Installer/Package.wxs`

### 3. Script standalone `copy-sql-files.ps1`

Se creó un script independiente que puede ejecutarse manualmente o como parte del proceso de instalación para copiar los archivos SQL y configurar permisos.

**Archivo creado:** `/src/FichaCosto.Installer/scripts/copy-sql-files.ps1`

## Mapa de trazabilidad R<n> → cambios

| Requisito | Cambio implementado | Archivo(s) |
|-----------|---------------------|------------|
| R1: Scripts de instalación deben preparar BD | post-install.ps1 copia archivos SQL | post-install.ps1 |
| R2: Estructura de directorios post-instalación | Directorio Data/ en ProgramData con permisos | post-install.ps1 |
| R3: Inicialización de BD en producción | DatabaseInitializer encuentra Schema.sql | DatabaseInitializer.cs (verificado) |
| R4: Connection string apunta a ProgramData | appsettings.Production.json (verificado) | appsettings.Production.json |
| R5: Script de diagnóstico | copy-sql-files.ps1 con logging | copy-sql-files.ps1 |

## Archivos modificados/creados

| Archivo | Tipo | Descripción |
|---------|------|-------------|
| `src/FichaCosto.Installer/post-install.ps1` | Modificado | Copia archivos SQL a ProgramData |
| `src/FichaCosto.Installer/Package.wxs` | Modificado | Componentes CopyFile para instalación |
| `src/FichaCosto.Installer/scripts/copy-sql-files.ps1` | Creado | Script standalone de copia |

## Pruebas realizadas

- [ ] Verificar que build.ps1 compila MSI sin errores
- [ ] Verificar que MSI instala archivos SQL en ProgramData
- [ ] Verificar que servicio inicia y crea BD correctamente
- [ ] Verificar que Swagger UI es accesible

## Notas adicionales

La solución sigue un enfoque de "defensa en profundidad":
1. **Primera línea:** WiX CopyFile durante la instalación MSI
2. **Segunda línea:** post-install.ps1 como fallback
3. **Tercera línea:** Script standalone para reparación manual

