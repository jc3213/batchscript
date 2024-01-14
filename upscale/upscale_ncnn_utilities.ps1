Add-Type -AssemblyName System.Windows.Forms

function Set-Scale {
    Write-Host "`n`n============================================================"
    Write-Host "1. Scale 2x (Default)"
    Write-Host "2. Scale 4x"
    Write-Host "============================================================"
    $scale = Read-Host ">"

    if ($scale -eq "2") {
        $ratio = "4"
    } else {
        $ratio = "2"
    }

    $script:name += "($ratio`x)"
    $script:params = " -s $ratio"
    $script:scale = $ratio
}

function Set-Denoise {
    Write-Host "`n`n============================================================"
    Write-Host "Denoise Level: -1 ~ 3"
    Write-Host "Default: 0"
    Write-Host "============================================================"
    $denoise = Read-Host ">"

    if ($denoise -notmatch "^(-1|[0-3])$") {
        $denoise = "0"
    }

    $script:name += "(Lv.$denoise)"
    $script:params += " -n $denoise"
    $script:denoise = $denoise
}

function Set-Tile {
    Write-Host "`n`n============================================================"
    Write-Host "Split Tiles: 0 ~ 144"
    Write-Host "Default: 0 (Auto)"
    Write-Host "============================================================"
    $tile = Read-Host ">"

    if ($tile -notmatch "^([0-9]|[1-9][0-9]|1[0-3][0-9]|14[0-4])$") {
        $tile = "0"
    }

    $script:params += " -t $tile"
    $script:tile = $tile
}

function Set-TTA {
    Write-Host "`n`n============================================================"
    Write-Host "1. Enable TTA Mode"
    Write-Host "============================================================"
    $tta = Read-Host ">"

    if ($tta -eq "1") {
        $script:name += "(TTA)"
        $script:params += " -x"
        $script:tta = $true
    }
}

function Set-Format {
    Write-Host "`n`n============================================================"
    Write-Host "1. jpg"
    Write-Host "2. png (Default)"
    Write-Host "3. webp"
    Write-Host "============================================================"
    $format = Read-Host ">"

    switch ($format) {
        "1" {
            $script:format = "jpg"
        }
        "3" {
            $script:format = "webp"
        }
        default {
            $script:format = "png"
        }
    }
}

function Upscale-Output {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "Upscaler   :   $script:worker"
    Write-Host "Model      :   $script:model"
    Write-Host "Scale      :   $script:scale`x"
    Write-Host "Tile       :   $script:tile"
    if ($script:denoise) {
        Write-Host "Denoise    :   Lv.$script:denoise"
    }
    if ($script:tta) {
        Write-Host "TTA Mode   :   Enabled"
    }
    Write-Host "============================================================"

    $appx = "$PSScriptRoot\bin\$script:app-ncnn-vulkan.exe"
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Multiselect = $true
    $dialog.Filter = "Image files|*.jpg;*.png;*.avif;*.webp;*."
    $result = $dialog.ShowDialog()

    if ($result -ne "OK") {
        return
    }

    foreach ($file in $dialog.FileNames) {
        Write-Host "`n`nProcessing: `"$file`""
        $folder = Split-Path -Path $file -Parent
        $name = [System.IO.Path]::GetFileNameWithoutExtension($file) + " $script:name.$script:format"
        $output = "$folder$name"
        Start-Process -FilePath "$appx" -ArgumentList "-i `"$file`" -o `"$output`" $script:params" -Wait -WindowStyle Hidden
        Write-Host "Output file: `"$output`""
    }
    Pause
}

function ESRGAN-CUGAN {
    Set-Tile
    Set-Format
    Upscale-Output
}

function Waifu2x-CUGAN {
    Set-Scale
    Set-Denoise
    Set-Tile
    Set-TTA
    Set-Format
    Upscale-Output
}

while ($true) {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "1. Real-ESRGAN Plus Anime"
    Write-Host "2. Real-ESRGAN Anime Video v3"
    Write-Host "3. Real-CUGAN Se"
    Write-Host "4. Real-CUGAN Pro"
    Write-Host "5. Waifu2x CUnet"
    Write-Host "6. Waifu2x Anime Style"
    Write-Host "============================================================"
    $model = Read-Host ">"

    switch ($model) {
        "1" {
            $script:app = "realesrgan"
            $script:model = "x4plus-anime"
            $script:scale = "4"
            $script:worker = "Real-ESRGAN"
            $script:name = "(realesrgan))(x4plus-anime)(4x)"
            $script:params = "-n realesrgan-x4plus-anime"
            ESRGAN-CUGAN
        }
        "2" {
            $script:app = "realesrgan"
            $script:model = "animevideov3"
            $script:worker = "Real-ESRGAN"
            $script:name = "(realesrgan)(animevideov3)"
            $script:params = "-n realesr-animevideov3"
            Set-Scale
            ESRGAN-CUGAN
        }
        "3" {
            $script:app = "realcugan"
            $script:model = "se"
            $script:worker = "Real-CUGAN"
            $script:name = "(realcugan)(se)"
            $script:params = "-m models-se"
            Waifu2x-CUGAN
        }
        "4" {
            $script:app = "realcugan"
            $script:model = "pro"
            $script:scale = "2"
            $script:worker = "Real-CUGAN"
            $script:name = "(realcugan)(pro)(2x)"
            $script:params = "-m models-pro -s 2"
            Set-Denoise
            ESRGAN-CUGAN
        }
        "5" {
            $script:app = "waifu2x"
            $script:model = "cunet"
            $script:worker = "Waifu2x"
            $script:name = "(waifu2x)(cunet)"
            $script:params = "-m models-cunet"
            Waifu2x-CUGAN
        }
        "6" {
            $script:app = "waifu2x"
            $script:model = "upconv_7_anime_style_art_rgb"
            $script:worker = "Waifu2x"
            $script:name = "(waifu2x)(upconv_7_anime_style_art_rgb)"
            $script:params = "-m models-upconv_7_anime_style_art_rgb"
            Waifu2x-CUGAN
        }
    }
}
