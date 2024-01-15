Add-Type -AssemblyName System.Windows.Forms

function Set-Directory {
    $directory = Join-Path $PSScriptRoot "Youtube-DL"

    Write-Host "`n`nDownload Directory"
    Write-Host "============================================================"
    Write-Host "$directory [Default]"
    Write-Host "============================================================"

    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $result = $dialog.ShowDialog()

    if ($result -eq "OK") {
        $directory = $dialog.SelectedPath
    }

    $script:params += " --output `"$directory\%(title)s.%(ext)s`""
    $script:directory = $directory
    $regexp = "^([a-zA-Z]:)?(\\?[^<>:|?!*&#`"/]+)$"
}

function Set-History {
    Write-Host "`n`nDownload History"
    Write-Host "============================================================"
    Write-Host "Bypass to avoid saving download history"
    Write-Host "============================================================"

    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "Text file|*.txt;*"
    $result = $dialog.ShowDialog()

    if ($result -eq "OK") {
        $script:params += " --download-archive `"" + $dialog.FileName + "`""
        $script:history = $dialog.FileName
        $regexp = "^([a-zA-Z]:)?(\\?[^<>:|?!*&#`"/]+)\.txt$"
    }
}

function Set-Proxy {
    Write-Host "`n`nProxy Server"
    Write-Host "============================================================"
    Write-Host "Sample: 127.0.0.1:1080"
    Write-Host "Keep EMPTY if you don't use a proxy server"
    Write-Host "============================================================"
    $proxy = Read-Host ">"

    if ($proxy -match "^(http(s)?://)?([\w-]+\.)+[\w-]+(:[\d-]+)?/?$") {
        $script:params += " --proxy `"$proxy`""
        $script:proxy = $proxy
    }
}

function Set-Subtitle {
    Write-Host "`n`nDownload Subtitle"
    Write-Host "============================================================"
    Write-Host "1. Yes"
    Write-Host "0. No [Default]"
    Write-Host "============================================================"
    $subtitle = Read-Host ">"

    if ($subtitle -eq "1") {
        $script:params += " --all-subs"
        $script:subtitle = $true
    }
}

function Set-Aria2c {
    $aria2c = Join-Path $PSScriptRoot "bin\aria2c.exe"
    
    if (Test-Path $aria2c) {
        $script:params += " --external-downloader `"aria2c`" --external-downloader-args `"-c -j 10 -x 10 -s 10 -k 1M`""
        $script:aria2c = $true
    }
}

function Youtube-Download {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "Selected Quality    :   $script:quality"
    Write-Host "Download Directory  :   $script:directory"
    if ($script:history) {
        Write-Host "Download History    :   $script:history"
    }
    if ($script:proxy) {
        Write-Host "Proxy Server        :   $script:proxy"
    }
    if ($script:subtitle) {
        Write-Host "Download Subtitles  :   all"
    }
    if ($script:aria2c) {
        Write-Host "External Downloader :   aria2c"
    }
    Write-Host "============================================================"
    $appx = "$PSScriptRoot\bin\youtube-dl.exe"

    while ($true) {
        $uri = Read-Host "`n`nVideo Uri"
        Start-Process -FilePath "$appx" -ArgumentList "$script:params $uri" -Wait -NoNewWindow
    }
}

function Set-Quality {
    Clear-Host
    Write-Host "Video Quality"
    Write-Host "============================================================"
    Write-Host "1. Best Video & Audio [Default]"
    Write-Host "2. Best Video & Audio @1080p"
    Write-Host "3. Best Video & Audio @2K"
    Write-Host "4. Best Video & Audio @4K"
    Write-Host "5. Only Audio"
    Write-Host "6. Only Audio (AAC)"
    Write-Host "============================================================"
    $format = Read-Host ">"

    switch ($format) {
        "2" {
            $script:quality = "Best Video & Audio @1080p"
            $script:params = "--format `"bestvideo[height<=1080]+bestaudio/best[height<=1080]`""
        }
        "3" {
            $script:quality = "Best Video & Audio @1440p"
            $script:params = "--format `"bestvideo[height<=1440]+bestaudio/best[height<=1440]`""
        }
        "4" {
            $script:quality = "Best Video & Audio @2160p"
            $script:params = "--format `"bestvideo[height<=2160]+bestaudio/best[height<=2160]`""
        }
        "5" {
            $script:quality = "Best Audio Only"
            $script:params = "--format `"bestaudio`""
        }
        "6" {
            $script:quality = "Best Audio Only (AAC)"
            $script:params = "--format `"bestaudio[acodec~='(aac|mp4a)']`""
        }
        default {
            $script:quality = "Best Video & Audio"
            $script:params = "--format `"bestvideo+bestaudio/best`""
        }
    }
}

Set-Quality
Set-Directory
Set-History
Set-Proxy
Set-Subtitle
Set-Aria2c
Youtube-Download
