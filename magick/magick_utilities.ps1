Add-Type -AssemblyName System.Windows.Forms
$imagick = Join-Path $PSScriptRoot "bin\magick.exe"

function Set-Area ($action) {
    Write-Host "`n`n============================================================"
    Write-Host "https://imagemagick.org/script/command-line-processing.php#geometry"
    Write-Host "Sample: 300x100 (width x height)"
    Write-Host "Cut left and right: 300px(width), cut top and bottom: 100px(height)"
    Write-Host "Sample: 300x100+20+30 (width x height + left + top)"
    Write-Host "Crop image area start from: left 20px to 320px, top: 30px to 130px"
    Write-Host "Sample: 200x100%+50 (width x height + left)"
    Write-Host "Crop image area start from: left 50px to 250px, top: 100%"
    Write-Host "============================================================"
    $area = Read-Host ">"

    if ($area -eq $null) {
        Set-Area
    }

    $script:name = "[cropped][$area]"
    $script:params = "-$action $area"
    $script:method = "convert"
}

function Set-Format {
    Write-Host "`n`n============================================================"
    Write-Host "1. jpg"
    Write-Host "2. png [Default]"
    Write-Host "3. avif"
    Write-Host "4. webp"
    Write-Host "============================================================"
    $format = Read-Host ">"

    switch ($format) {
        "1" {
            $script:format = "jpg"
         }
        "3" {
            $script:format = "avif"
        }
        "4" {
            $script:format = "webp"
        }
        default {
            $script:format = "png"
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

    $script:name = "[output][$script:format][$quality]"
    $script:params = "-quality $quality"
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

    $script:name = "[darken][$darken]"
    $script:params = "-level $darken%,100%"
    
}

function Set-Resize {
    Write-Host "`n`n============================================================"
    Write-Host "Sample: 300x100 (width x height)"
    Write-Host "Resize image to width 300px and height 100px"
    Write-Host "Sample: 500x (width), or x400 (height)"
    Write-Host "Resize image and keep aspect ratio"
    Write-Host "Sample: 50%"
    Write-Host "Resize image to 50% of its size"
    Write-Host "============================================================"
    $resize = Read-Host ">"

    if ($resize-eq $null) {
        Set-Resize
    }

    $script:name = "[resize][$resize]"
    $script:params = "-resize $resize"
    $script:method = "convert"
}

function Run-Imagick {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Multiselect = $true
    $dialog.Filter = "Image files|*.jpg;*.png;*.avif;*.webp;*."
    $result = $dialog.ShowDialog()

    if ($result -ne "OK") {
        return
    }

    foreach ($file in $dialog.FileNames) {
        Write-Host "`n`nImagick is processing: `"$file`""
        $folder = Split-Path -Path $file -Parent
        if ($script:format) {
            $name = [System.IO.Path]::GetFileNameWithoutExtension($file) + "$script:format"
        } else {
            $name = Split-Path -Path $file -Leaf
        }
        $output = "$script:name $name"
        Start-Process -FilePath $imagick -ArgumentList "$script:method `"$file`" $script:params `"$folder\$output`"" -Wait -WindowStyle Hidden
        Write-Host "Output file: `"$output`""
    }
    Pause
}

while ($true) {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "1. Crop with area"
    Write-Host "2. Cut off border"
    Write-Host "3. Convert format"
    Write-Host "4. Darken images"
    Write-Host "5. Resize images"
    Write-Host "============================================================"
    $type = Read-Host ">"
    switch ($type) {
        "1" {
            Set-Area "crop"
            Run-Imagick
        }
        "2" {
            Set-Area "shave"
            Run-Imagick
        }
        "3" {
            Set-Format
            Set-Quality
            Run-Imagick
        }
        "4" {
            Set-Darken
            Run-Imagick
        }
        "5" {
            Set-Resize
            Run-Imagick
        }
    }
}
