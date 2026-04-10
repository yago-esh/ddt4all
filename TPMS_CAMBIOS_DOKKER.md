# Cambios TPMS - Dacia Dokker 2018 (X67)

## Problema
Sensor de presión de la **rueda 4 (trasera derecha)** con batería agotada.
Genera error constante en el cuadro de instrumentos.

## DTCs originales
- **DTC #0 - DI_RR_RIGHT (0x9504)**: circuit short to ground or open
- **DTC #1 - WL_AUTHORIZATION_RL (0x9510)**: circuit short to ground or open

---

## Cambios realizados

### 1. Vehicle Config
**Ruta:** ECU List → UCH (26) → Ecran Window → TPMS_SCREENS → Vehicle Config

| Parámetro | Valor original | Valor cambiado |
|---|---|---|
| `TPMS_PRESENCE_SSPP` | true | **false** |

> Desactiva la monitorización TPMS en la UCH. Es el cambio principal.

### 2. System Config
**Ruta:** ECU List → UCH (26) → Ecran Window → TPMS_SCREENS → System Config

| Parámetro | Valor original | Valor cambiado |
|---|---|---|
| `TPMS_AUTOLEARNING_ACTIVED` | true | **false** |
| `TPMS_FLAG_MISSING_SENSOR_ENABLE` | false | false (sin cambio) |

> Evita que el sistema intente re-aprender sensores y genere nuevas alertas.

### 3. Borrado de DTCs
Se borraron los códigos de error almacenados en la UCH.

---

## Para reactivar (cuando se cambie el sensor)

1. Conectar ELM327 USB al OBD2, contacto puesto
2. Abrir ddt4all con `start_ddt4all.bat`
3. Ir a **UCH (26)** en el panel izquierdo
4. En **TPMS_SCREENS → Vehicle Config**:
   - `TPMS_PRESENCE_SSPP` → cambiar a **true** → Send
5. En **TPMS_SCREENS → System Config**:
   - `TPMS_AUTOLEARNING_ACTIVED` → cambiar a **true** → Send
6. Quitar contacto, esperar 30 segundos, volver a dar contacto
7. Conducir unos minutos para que el sistema re-aprenda los sensores

---

## Notas
- El Dokker 2018 usa TPMS indirecto (via ABS, sin receptor RF dedicado)
- `LIN_RECEIVER_ACTIVATION` = false (no hay receptor LIN para sensores)
- Los `TPMS_WHEEL_ID` aparecen como NO DATA porque no hay sensores RF emparejados
- El error `7F3E12` en los logs (SubFunction Not Supported) es del TesterPresent keepalive, no afecta al funcionamiento
- Con TPMS desactivado no se recibirán alertas de presión baja en ninguna rueda
- Posible problema en ITV si verifican el testigo TPMS
