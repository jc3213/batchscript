$imagick = Join-Path $PSScriptRoot "bin\magick.exe"

function Set-Area {
    Write-Host "`n`n============================================================"
    Write-Host "https://imagemagick.org/script/command-line-processing.php#geometry"
    Write-Host "Sample: 300x100 (width x height)"
    Write-Host "Cut left and right: 300px(width), cut top and bottom: 100px(height)"
    Write-Host "Sample: 300x100+20+30 (width x height + left + top)"
    Write-Host "Crop image area start from: left 20px to 320px, top: 30px to 130px"
    Write-Host "============================================================"
    $global:area = Read-Host ">"
}

function Set-Format {
    Write-Host "`n`n============================================================"
    Write-Host "1. jpg"
    Write-Host "2. png"
    Write-Host "3. avif"
    Write-Host "============================================================"
    $format = Read-Host ">"
    switch ($format) {
        "1" {
            $global:format = "jpg"
         }
        "2" {
            $global:format = "png"
        }
        "3" {
            $global:format = "avif"
        }
        default {
            Set-Format
        }
    }
}

function Set-Quality {
    Write-Host "`n`n============================================================"
    Write-Host "Set image quality: 1-100"
    Write-Host "Default: 90"
    Write-Host "============================================================"
    $quality = Read-Host ">"
    if ($quality -notmatch "^[1-9]$|^[1-9][0-9]$|^100$") {
        $quality = 90
    }
    $global:quality = $quality
}

function Set-Darken {
    Write-Host "`n`n============================================================"
    Write-Host "Set minimum color level: 0-100"
    Write-Host "Default: 30"
    Write-Host "============================================================"
    $darken = Read-Host ">"
    if ($darken -notmatch "^[1-9]$|^[1-9][0-9]$|^100$") {
        $darken = "30"
    }
    $global:level = $darken + "%,100%"
}

function Get-Files {
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Multiselect = $true
    $dialog.Filter = "Image files|*.jpg;*.png;*.avif;*.webp;*."
    $result = $dialog.ShowDialog()

    if ($result -eq "OK") {
        $global:files = $dialog.FileNames
    }
}

function Get-Imagick ($params, $extra, $method) {
    foreach ($file in $global:files) {
        Write-Host "`n`nImagick is processing: `"$file`""
        $folder = Split-Path -Path $file -Parent
        if ($global:format) {
            $name = [System.IO.Path]::GetFileNameWithoutExtension($file) + ".$global:format"
        } else {
            $name = Split-Path -Path $file -Leaf
        }
        $output = "$extra`_$name"
        Start-Process -FilePath $imagick -ArgumentList "$method `"$file`" $params `"$folder\$output`"" -NoNewWindow -Wait
        Write-Host "Output file: `"$output`""
    }
    Pause
}

while ($true) {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "1. Crop with area"
    Write-Host "2. Cut off border"
    Write-Host "3. Convert images"
    Write-Host "4. Darken images"
    Write-Host "============================================================"
    $type = Read-Host ">"
    switch ($type) {
        "1" {
            Set-Area
            Get-Files
            Get-Imagick "-crop $global:area" "cutted" "convert"
        }
        "2" {
            Set-Area
            Get-Files
            Get-Imagick "-shave $global:area" "cutted" "convert"
        }
        "3" {
            Set-Format
            Set-Quality
            Get-Files
            Get-Imagick "-quality $global:quality" "output"
        }
        "4" {
            Set-Darken
            Get-Files
            Get-Imagick "-level $global:level" "darken"
        }
    }
}
