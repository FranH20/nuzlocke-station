#!/bin/bash

# Ruta de config
CONF="/config/rclone_conf/rclone.conf"

echo "🔄 [Sync] Iniciando daemon..."

# CORRECCIÓN DE RUTAS:
# Asegúrate que aquí diga "/data/roms" (coincide con Dockerfile)
# Asegúrate que "drive:Pokemon/Roms" sea como está en tu Drive
rclone sync drive:Pokemon/Roms /data/roms --transfers=4 --config "$CONF"
rclone sync drive:Pokemon/Saves /data/saves --transfers=4 --config "$CONF"

echo "✅ [Sync] Carga inicial completa."

while true; do
    sleep 30
    rclone copy /data/saves drive:Pokemon/Saves --include "*.sav" --include "*.dsv" --config "$CONF"
done