# Sygmatch 🚀

Sygmatch es un potente script interactivo en PowerShell diseñado para descargar videos y audios de YouTube y múltiples plataformas web de forma sencilla, rápida y avanzada. Combina la potencia de **yt-dlp** y **ffmpeg** para ofrecerte el máximo control sobre tus descargas multimedia.

---

## ✨ Características Principales

* **Descarga Dual Inteligente:** Elige entre descargar en formato de **Video** (con selección de calidad: 4K, 1080p, 720p, 480p) o **Audio** (convertido a MP3 en máxima calidad de 320 kbps, estandar 192 kbps, M4A/AAC, FLAC o sin conversión).
* **Gestión Flexible de Enlaces:** Soporta tanto videos individuales como listas de reproducción (*playlists*) completas.
* **Instalación Automática de Dependencias:** Si no cuentas con `yt-dlp` o `ffmpeg` en tu equipo, el script los detecta y los descarga/configura automáticamente en una carpeta local `tools`.
* **Interfaz Gráfica Amigable:** Permite seleccionar la carpeta de destino y el nombre del archivo de forma interactiva mediante ventanas emergentes de Windows.

---

## 🛠️ Requisitos del Sistema

* **Sistema Operativo:** Windows 10 / 11 con **PowerShell** instalado.
* **Conexión a Internet:** Requerida para la descarga inicial de las herramientas y el contenido multimedia.

---

## 🚀 Uso Rápido

1. Clona o descarga este repositorio en tu equipo.
2. Abre una terminal de PowerShell dentro de la carpeta del proyecto.
3. Ejecuta el script principal:
   ```powershell
   .\Sygmatch YT Downloader.ps1
