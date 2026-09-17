# Sygmatch Downloader

Sygmatch Downloader es una herramienta de escritorio desarrollada en PowerShell 5.1 con interfaz gráfica nativa (Windows Forms). Fue diseñada para simplificar la descarga de contenido multimedia desde internet, ofreciendo un panel de control accesible para gestionar resoluciones, formatos de audio y carpetas de destino sin necesidad de interactuar con la consola de comandos.

## Qué hace el script

El programa actúa como una interfaz visual que gestiona por debajo motores de procesamiento multimedia como `yt-dlp` y `ffmpeg`. Durante su primer inicio, verifica la existencia de estas herramientas en la carpeta local `tools`. Si no las encuentra, se encarga de descargarlas y dejarlas listas para trabajar.

* **Descarga de Video y Audio:** Permite elegir entre obtener el archivo de video completo o extraer únicamente la pista de audio.
* **Formatos y Calidad:** Admite resoluciones desde 480p y 720p HD hasta 1080p Full HD y 4K (siempre que el origen lo permita). En audio, exporta a MP3 (máxima calidad o 192 kbps), M4A/AAC, FLAC sin pérdida o la pista original.
* **Soporte de Listas de Reproducción:** Procesa tanto videos individuales como listas de reproducción completas mediante una opción dedicada.
* **Consola de Operaciones Integrada:** Muestra el progreso detallado, velocidades de transferencia y advertencias en tiempo real.
* **Interfaz Adaptable:** Ventana redimensionable que ajusta sus paneles automáticamente al cambiar de tamaño.
* **Integración Nativa:** Incluye el explorador de carpetas nativo de Windows para seleccionar el directorio de guardado y limpia la casilla de texto tras iniciar cada proceso para agilizar descargas continuas.

## Plataformas compatibles

Gracias al motor `yt-dlp`, la herramienta admite enlaces de más de 1000 sitios web y redes sociales.

* **Redes Sociales:** YouTube (Videos, Shorts, Playlists), TikTok, Facebook, Instagram (publicaciones y Reels públicos), X (Twitter), Pinterest y Threads.
* **Streaming y Video:** Twitch, Kick, Vimeo, Dailymotion y Rumble.
* **Audio y Música:** SoundCloud, Bandcamp, Mixcloud y Freesound.
* **Otros Sitios:** Reddit, Bilibili, VK y portales de noticias o alojamiento de video directo.

*Aviso de limitación en Instagram u Otros:* Los Reels o publicaciones públicas se descargan sin problema. No obstante, el contenido de cuentas privadas, publicaciones con restricción de edad o elementos limitados por la plataforma pueden ser bloqueados por los sistemas de seguridad de Meta.

## Requisitos de uso

1. Sistema operativo Windows 10 o Windows 11.
2. PowerShell 5.1 (incluido por defecto en Windows).
3. Conexión a internet activa para la descarga inicial de las herramientas secundarias.
