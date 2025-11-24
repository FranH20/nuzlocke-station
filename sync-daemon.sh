#!/bin/bash
echo "🔄 [Sync] Iniciando descarga de ROMs y Saves desde Drive..."

# 1. PULL INICIAL
# Descargamos los archivos (esto los crea como root)
rclone sync drive:Pokemon/Roms /data/roms --transfers=4
rclone sync drive:Pokemon/Saves /data/saves --transfers=4

# Le damos la propiedad de TODOS los archivos en /data al usuario 1000 (tú)
echo "🔧 [Fix] Corrigiendo permisos para el usuario..."
chown -R 1000:1000 /data/roms
chown -R 1000:1000 /data/saves
chmod -R 777 /data/saves  # Permisos totales para evitar cualquier duda
# ---------------------

echo "✅ [Sync] Carga inicial completa. Permisos corregidos."

# 2. WATCH LOOP
while true; do
    sleep 30
    # Subimos los saves (rclone copy solo lee, no cambia permisos, así que esto es seguro)
    rclone copy /data/saves drive:Pokemon/Saves --include "*.sav" --include "*.dsv"
done