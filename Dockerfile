FROM lscr.io/linuxserver/webtop:arch-xfce

# CORRECCIÓN: Agregamos 'lua' y 'libzip' explícitamente para evitar errores de librerías
RUN pacman -Sy --noconfirm \
    mgba-qt \
    rclone \
    dos2unix \
    lua \
    libzip \
    && pacman -Scc --noconfirm

# 2. Crear carpetas base
RUN mkdir -p /data/roms /data/saves

# 3. Copiamos el script
COPY sync-daemon.sh /defaults/sync-daemon.sh

# 4. Configurar el servicio
RUN mkdir -p /etc/s6-overlay/s6-rc.d/svc-sync && \
    printf "#!/bin/bash\n\
dos2unix /defaults/sync-daemon.sh\n\
chmod +x /defaults/sync-daemon.sh\n\
/bin/bash /defaults/sync-daemon.sh\n" > /etc/s6-overlay/s6-rc.d/svc-sync/run && \
    chmod +x /etc/s6-overlay/s6-rc.d/svc-sync/run && \
    echo "longrun" > /etc/s6-overlay/s6-rc.d/svc-sync/type && \
    touch /etc/s6-overlay/s6-rc.d/user/contents.d/svc-sync

# 5. Permisos Nucleares: Asegurar que cualquiera (abc o root) pueda escribir en data
RUN chmod -R 777 /data

# Metadatos
LABEL maintainer="tu-usuario"
LABEL description="Nuzlocke Station"