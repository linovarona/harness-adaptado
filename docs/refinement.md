# docs/refinement.md — Refinamiento Conversacional

> Proceso de captura de requisitos en lenguaje natural antes del SDD formal.
> Resultado: `feature_list.json` enriquecido + `progress/refinement_<feature_id>.md` documentado.

## ¿Cuándo usar?

- Historia de usuario nueva e incompleta
- Usuario no tiene spec escrita
- Necesidad de descubrir reglas de negocio ocultas, nomencladores, o formatos de datos reales
- Feature con complejidad de dominio que requiere iteración antes de formalizar

## ¿Cuándo OMITIR?

- Feature trivial (ej. "cambiar color de botón")
- Feature ya especificada en otro documento
- Bug fix con reproducción clara

## Proceso

### Fase 0.1: Historia de usuario
**Usuario** describe la necesidad en lenguaje natural.

> Ejemplo: "Desglose de Estado de Cuenta desde Excel, totalizar créditos/débitos..."

### Fase 0.2: Asunciones del agente
**Agente** lista asunciones numeradas, separando:
- **Técnicas/funcionales**: implícitas en la HU (ej. formato .xlsx)
- **No técnicas/funcionales**: necesitan validación (ej. formato de salida)

### Fase 0.3: Rechazo y preguntas
**Usuario** indica números de asunciones que no le gustan.

**Agente** pregunta **una a una** con barra de progreso:
```
[████████░░░░░░░░░░]  2/4  (50%)
```

Opciones: A/B/C/D/**E: Otra** → usuario especifica.

### Fase 0.4: Iteración
Repetir hasta que no queden asunciones sin validar.

### Fase 0.5: Documentación
Generar dos artefactos:

1. **`feature_list.json`** enriquecido:
   - `description` con reglas descubiertas
   - `notes` con contexto de negocio
   - `refinement`: ruta al `.md` de refinamiento

2. **`progress/refinement_<feature_id>.md`**:
   - Historia original
   - Asunciones listadas
   - Preguntas y respuestas
   - Nomencladores identificados
   - Datos reales analizados
   - Reglas de negocio consolidadas

## Reglas del refinamiento

- **Sin aprobación formal**: es conversación, no spec
- **No hay R<n> aún**: los requisitos se numeran en `requirements.md` (SDD)
- **Trazabilidad R<n>↔test**: se establece en fase SDD, no aquí
- **Repetibilidad**: mediante `progress/refinement_<id>.md` en disco
- **Append-only**: el `.md` solo crece, nunca se edita el pasado

## Estructura del archivo de refinamiento

```markdown
# Refinamiento: <feature_id>

## Historia de usuario original
[Texto original del usuario]

## Asunciones iniciales
| # | Asunción | Tipo |
|---|---|---|
| 1 | ... | Técnica |
| 2 | ... | No técnica |

## Asunciones rechazadas
5, 7, 9, 11

## Intercambio de preguntas

### Q1 (1/N): [Tema]
**Opciones:** A/B/C/D/E  
**Respuesta:** [Letra] — [Descripción]

### Q2 (2/N): [Tema]
...

## Nomencladores identificados
- [Nombre]: [Descripción] ([campos clave])

## Datos reales analizados
- [Archivo]: [Descripción]

## Reglas de negocio consolidadas
1. [Regla 1]
2. [Regla 2]

## Resultado
- `feature_list.json` generado
- Feature lista para fase SDD
```

## Transición al SDD

Una vez completado el refinamiento:

1. Agente lee `progress/refinement_<id>.md`
2. Agente crea `specs/<id>/requirements.md` (EARS, R1, R2...)
3. Agente crea `specs/<id>/design.md` (decisiones técnicas)
4. Agente crea `specs/<id>/tasks.md` (checklist)
5. **PAUSA** — espera aprobación humana
6. Luego: implementación, revisión, entrega

## Anti-patrones

- ❌ Saltar refinamiento en features complejas (riesgo de R<n> mal definidos)
- ❌ Mezclar refinamiento con SDD (son fases separadas)
- ❌ No generar el `.md` de refinamiento (pierde repetibilidad)
- ❌ Editar el `.md` de refinamiento después (append-only)
