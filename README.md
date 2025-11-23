# 🎮 Nuzlocke Cloud Station

**Una estación de emulación portátil, contenerizada y sincronizada en la nube.**

> *Gaming as a Microservice.*

Este proyecto despliega un entorno de escritorio Linux ligero (Arch XFCE) dentro de un contenedor Docker, pre-configurado con emuladores (mGBA, MelonDS) y un sistema de sincronización bidireccional con Google Drive. Permite jugar partidas de Pokémon (o cualquier juego retro) manteniendo la persistencia del guardado (`.sav`) entre diferentes sistemas operativos (Windows, macOS, Linux) sin fricción.

---

## 🚀 Características Principales

* **☁️ Persistencia en la Nube:** Sincronización automática de partidas guardadas (`.sav`) con Google Drive usando un demonio personalizado de Rclone.
* **🐳 100% Dockerizado:** Sin instalaciones nativas. Ejecuta `docker-compose up` y juega.
* **🖥️ Acceso vía Navegador:** Utiliza tecnología KasmVNC para renderizar el escritorio en `localhost:3000`.
* **🍎🪟 Multi-Arquitectura:** Compatible nativamente con Apple Silicon (M1/M2/M3) y Windows/Linux (x86_64).
* **🛠️ Developer Friendly:** Configuración mediante variables de entorno y volúmenes Docker.

---

## 🏗️ Arquitectura

El proyecto utiliza una arquitectura de **Stateful Container**:

1.  **Base Image:** `linuxserver/webtop:arch-xfce` (Arch Linux ligero).
2.  **Emuladores:** `mGBA` (GBA/GBC) y `MelonDS` (NDS) instalados vía `pacman`.
3.  **Sync Daemon:** Un script en Bash (`sync-daemon.sh`) que se ejecuta en segundo plano para:
    * Realizar un **PULL** inicial de ROMs y Saves al arrancar.
    * Realizar un **PUSH** de los archivos `.sav` cada 30 segundos (Watch Loop).
4.  **Storage:** `rclone` gestiona la conexión segura con Google Drive.

---

## 📋 Requisitos Previos

* [Docker](https://www.docker.com/) y Docker Compose instalados.
* *(En macOS)* Se recomienda [OrbStack](https://orbstack.dev/) para mejor rendimiento.
* Una cuenta de Google Drive.
* Tus propios archivos de ROMs (legalmente obtenidos).

---

## ⚙️ Instalación y Despliegue

### 1. Clonar el Repositorio
```bash
git clone [https://github.com/TU_USUARIO/nuzlocke-station.git](https://github.com/TU_USUARIO/nuzlocke-station.git)
cd nuzlocke-station