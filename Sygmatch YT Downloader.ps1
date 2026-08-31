<#
.SYNOPSIS
    Sygmatch - Descargador Avanzado de Video y Audio mediante yt-dlp y ffmpeg
.DESCRIPTION
    Script interactivo en PowerShell para descargar videos y audios de YouTube y otras plataformas.
#>

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

function Write-Spaced {
    param([string]$Text, [int]$LinesAfter = 1)
    Write-Host $Text
    for ($i = 0; $i -lt $LinesAfter; $i++) {
        Write-Host ""
    }
}

$ToolsDir = "$PSScriptRoot\tools"
$YtDlpPath = "$ToolsDir\yt-dlp.exe"
$FfmpegPath = "$ToolsDir\ffmpeg.exe"

function Check-And-Install-Tools {
    Clear-Host
    Write-Host "   ___                               _       _     " -ForegroundColor Cyan
    Write-Host "  / __|  _   _  __ _ _ __ ___   __ _| |_ ___| |__  " -ForegroundColor Cyan
    Write-Host "  \__ \ | | | |/ _`  |' _ ` _  \ / _`  | __/ __| '_ \ " -ForegroundColor Cyan
    Write-Host "  |___/ | |_| | (_| | | | | | | (_| | || (__| | | |" -ForegroundColor Cyan
    Write-Host "  |____/ \__, |\__, |_| |_| |_|\__,_|\__\___|_| |_| " -ForegroundColor Cyan
    Write-Host "         |___/ |___/                                " -ForegroundColor Cyan
    Write-Host ""
    Write-Host ""
    Write-Host "    Herramienta de Descarga Multimedia Pro       " -ForegroundColor Magenta
    Write-Host "==================================================" -ForegroundColor DarkGray
    Write-Host ""
    
    if (-not (Test-Path $ToolsDir)) {
        New-Item -ItemType Directory -Force -Path $ToolsDir | Out-Null
    }

    if (-not (Test-Path $YtDlpPath)) {
        Write-Spaced "[-] yt-dlp no se encuentra en el sistema. Descargando ultima version oficial..." 1
        $YtDlpUrl = "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"
        try {
            Invoke-WebRequest -Uri $YtDlpUrl -OutFile $YtDlpPath -UseBasicParsing
            Write-Spaced "[+] yt-dlp descargado exitosamente." 1
        } catch {
            Write-Spaced "[!] Error al descargar yt-dlp. Verifica tu conexion a internet." 2
            pause
            exit
        }
    } else {
        Write-Spaced "[+] yt-dlp detectado correctamente." 1
    }

    if (-not (Test-Path $FfmpegPath)) {
        Write-Spaced "[-] ffmpeg no se encuentra. Descargando binario oficial optimizado..." 1
        $FfmpegUrl = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
        $ZipPath = "$ToolsDir\ffmpeg.zip"
        try {
            Invoke-WebRequest -Uri $FfmpegUrl -OutFile $ZipPath -UseBasicParsing
            Write-Spaced "[+] Descomprimiendo ffmpeg..." 1
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipPath, "$ToolsDir\temp_ffmpeg")
            
            $extractedExe = Get-ChildItem -Path "$ToolsDir\temp_ffmpeg" -Filter "ffmpeg.exe" -Recurse
            if ($extractedExe) {
                Move-Item -Path $extractedExe.FullName -Destination $FfmpegPath -Force
            }
            Remove-Item -Path "$ToolsDir\temp_ffmpeg" -Recurse -Force
            Remove-Item -Path $ZipPath -Force
            Write-Spaced "[+] ffmpeg configurado exitosamente." 1
        } catch {
            Write-Spaced "[!] No se pudo descargar ffmpeg automaticamente." 2
        }
    } else {
        Write-Spaced "[+] ffmpeg detectado correctamente." 1
    }

    Start-Sleep -Seconds 1.5
}

function Show-Header {
    Clear-Host
    Write-Host "   ___                               _       _     " -ForegroundColor Cyan
    Write-Host "  / __|  _   _  __ _ _ __ ___   __ _| |_ ___| |__  " -ForegroundColor Cyan
    Write-Host "  \__ \ | | | |/ _`  | '_ `  _ \ / _`  | __/ __ | _ \ " -ForegroundColor Cyan
    Write-Host "  |___/ | |_| | (_| | | | | | | (_| | | |(__| | | |" -ForegroundColor Cyan
    Write-Host "  |____/ \__, |\__, |_| |_| |_|\__,_|\__\___|_| |_| " -ForegroundColor Cyan
    Write-Host "         |___/ |___/                                " -ForegroundColor Cyan
    Write-Host ""
    Write-Host ""
    Write-Host "  Descarga Inteligente de Videos y Audio de la Web " -ForegroundColor Magenta
    Write-Host "==================================================" -ForegroundColor DarkGray
    Write-Host ""
}

Check-And-Install-Tools

$continuar = $true

while ($continuar) {
    Show-Header

    Write-Host "Por favor, pega el enlace (URL) del contenido a descargar:" -ForegroundColor Green
    $url = Read-Host "URL"
    while ([string]::IsNullOrWhiteSpace($url)) {
        Write-Host "[!] La URL no puede estar vacia. Intentalo de nuevo." -ForegroundColor Red
        $url = Read-Host "URL"
    }
    Write-Host ""

    Write-Host "Que deseas descargar?" -ForegroundColor Green
    Write-Host "[1] Video (con calidades disponibles)"
    Write-Host "[2] Audio (convertido a formato y calidad elegida)"
    $tipo = Read-Host "Elige una opcion (1-2)"
    Write-Host ""

    Write-Host "Es un video individual o una lista de reproduccion?" -ForegroundColor Green
    Write-Host "[1] Video individual"
    Write-Host "[2] Lista de reproduccion completa (Playlist)"
    $alcance = Read-Host "Elige una opcion (1-2)"
    Write-Host ""

    $formatArg = ""
    if ($tipo -eq "1") {
        Write-Host "Selecciona la calidad de Video deseada:" -ForegroundColor Green
        Write-Host "[1] Mejor calidad disponible combinada (Recomendado - 4K/1080p)"
        Write-Host "[2] 1080p (Full HD - MP4)"
        Write-Host "[3] 720p (HD - MP4)"
        Write-Host "[4] 480p (SD - MP4)"
        $calidadVideo = Read-Host "Elige una opcion (1-4)"
        Write-Host ""

        switch ($calidadVideo) {
            "1" { $formatArg = "bv*+ba/b" }
            "2" { $formatArg = "bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[height<=1080][ext=mp4]/best" }
            "3" { $formatArg = "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]/best[height<=720][ext=mp4]/best" }
            "4" { $formatArg = "bestvideo[height<=480][ext=mp4]+bestaudio[ext=m4a]/best[height<=480][ext=mp4]/best" }
            default { $formatArg = "bv*+ba/b" }
        }
    } else {
        Write-Host "Que formato y calidad de audio prefieres?" -ForegroundColor Green
        Write-Host "[1] MP3 - Maxima calidad (320 kbps)"
        Write-Host "[2] MP3 - Calidad estandar (192 kbps)"
        Write-Host "[3] M4A / AAC (Audio de alta fidelidad original)"
        Write-Host "[4] FLAC (Formato sin perdida / Lossless)"
        Write-Host "[5] Calidad original sin convertir"
        $calidadAudio = Read-Host "Elige una opcion (1-5)"
        Write-Host ""

        switch ($calidadAudio) {
            "1" { $formatArg = "-x --audio-format mp3 --audio-quality 0" }
            "2" { $formatArg = "-x --audio-format mp3 --audio-quality 192k" }
            "3" { $formatArg = "-x --audio-format m4a" }
            "4" { $formatArg = "-x --audio-format flac" }
            "5" { $formatArg = "-x" }
            default { $formatArg = "-x --audio-format mp3 --audio-quality 0" }
        }
    }

    Write-Host "Selecciona la carpeta de destino en la ventana emergente..." -ForegroundColor Yellow
    Add-Type -AssemblyName System.Windows.Forms
    
    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.Title = "Sygmatch - Selecciona donde guardar tu archivo"
    $SaveFileDialog.FileName = "video_o_audio"
    $SaveFileDialog.Filter = "Todos los archivos (*.*)|*.*"
    $SaveFileDialog.AutoUpgradeEnabled = $true
    
    $folderPath = ""
    if ($SaveFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $folderPath = [System.IO.Path]::GetDirectoryName($SaveFileDialog.FileName)
    } else {
        $folderPath = $PSScriptRoot
        Write-Spaced "[!] No se selecciono carpeta. Se guardara en la ruta por defecto: $folderPath" 1
    }

    $outputTemplate = "$folderPath\%(title)s.%(ext)s"

    $playlistArg = ""
    if ($alcance -eq "2") {
        $playlistArg = "--yes-playlist"
    } else {
        $playlistArg = "--no-playlist"
    }

    Write-Spaced "==================================================" 1
    Write-Spaced "Iniciando descarga con Sygmatch..." 1
    Write-Spaced "==================================================" 2

    if ($tipo -eq "1") {
        & $YtDlpPath --ffmpeg-location $FfmpegPath -f $formatArg $playlistArg -o $outputTemplate $url
    } else {
        $audioArgsSplit = $formatArg.Split(" ")
        & $YtDlpPath --ffmpeg-location $FfmpegPath $audioArgsSplit $playlistArg -o $outputTemplate $url
    }

    Write-Spaced "" 1
    Write-Spaced "==================================================" 1
    Write-Spaced "Proceso de descarga finalizado con exito!" 2
    Write-Spaced "==================================================" 2

    Write-Host "Deseas realizar otra descarga?" -ForegroundColor Green
    Write-Host "[1] Si, quiero descargar otro archivo"
    Write-Host "[2] No, salir del programa"
    $respuestaContinuar = Read-Host "Elige una opcion (1-2)"
    
    if ($respuestaContinuar -ne "1") {
        $continuar = $false
        Write-Spaced "Gracias por utilizar Sygmatch! Hasta pronto." 1
        Start-Sleep -Seconds 1.5
    }
}
