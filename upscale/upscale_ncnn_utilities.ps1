Add-Type -AssemblyName System.Windows.Forms
$realesrgan = Join-Path $PSScriptRoot "bin\realesrgan-ncnn-vulkan.exe"
$realcugan = Join-Path $PSScriptRoot "bin\realcugan-ncnn-vulkan.exe"
$waifu2x = Join-Path $PSScriptRoot "bin\waifu2x-ncnn-vulkan.exe"

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
    Set-TTA
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
    Write-Host "Upscaler     :   $script:worker"
    Write-Host "Model        :   $script:model"
    Write-Host "Scale Ratio  :   $script:scale`x"
    if ($script:denoise) {
        Write-Host "Denoise      :   Lv.$script:denoise"
    }
    if ($script:tta) {
        Write-Host "TTA Mode     :   Enabled"
    }
    Write-Host "============================================================"

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
        Start-Process -FilePath $script:app -ArgumentList "-i `"$file`" -o `"$output`" $script:params" -Wait -WindowStyle Hidden
        Write-Host "Output file: `"$output`""
    }
    Pause
}

function ESRGAN-CUGAN {
    Set-Format
    Upscale-Output
}

function Waifu2x-CUGAN {
    Set-Scale
    Set-Denoise
    Set-Format
    Upscale-Output
}

while ($true) {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "1. Real-ESRGAN Plus"
    Write-Host "2. Real-ESRGAN Plus Anime"
    Write-Host "3. Real-ESRGAN Anime Video v3"
    Write-Host "3. Real-CUGAN Se"
    Write-Host "3. Real-CUGAN Pro"
    Write-Host "6. Waifu2x CUnet"
    Write-Host "7. Waifu2x Up-convert RGB"
    Write-Host "8. Waifu2x Up-convert Photo"
    Write-Host "============================================================"
    $model = Read-Host ">"

    switch ($model) {
        "1" {
            $script:app = $realesrgan
            $script:model = "x4plus"
            $script:scale = "4"
            $script:worker = "Real-ESRGAN"
            $script:name = "(real-esrgan)(x4plus)(4x)"
            $script:params = "-n realesrgan-x4plus -t 144"
            ESRGAN-CUGAN
        }
        "2" {
            $script:app = $realesrgan
            $script:model = "x4plus-anime"
            $script:scale = "4"
            $script:worker = "Real-ESRGAN"
            $script:name = "(real-esrgan))(x4plus-anime)(4x)"
            $script:params = "-n realesrgan-x4plus-anime"
            ESRGAN-CUGAN
        }
        "3" {
            $script:app = $realesrgan
            $script:model = "animevideov3"
            $script:worker = "Real-ESRGAN"
            $script:name = "(real-esrgan)(animevideov3)"
            $script:params = "-n realesr-animevideov3"
            Set-Scale
            ESRGAN-CUGAN
        }
        "4" {
            $script:app = $realcugan
            $script:model = "se"
            $script:worker = "Real-CUGAN"
            $script:name = "(real-cugan)(se)"
            $script:params = "-m models-se"
            Waifu2x-CUGAN
        }
        "5" {
            $script:app = $realcugan
            $script:model = "pro"
            $script:worker = "Real-CUGAN"
            $script:name = "(real-cugan)(pro)(2x)"
            $script:params = "-m models-pro -s 2"
            Set-Denoise
            ESRGAN-CUGAN
        }
        "6" {
            $script:app = $waifu2x
            $script:model = "cunet"
            $script:worker = "Waifu2x"
            $script:name = "(waifu2x)(cunet)"
            $script:params = "-m models-cunet"
            Waifu2x-CUGAN
        }
        "7" {
            $script:app = $waifu2x
            $script:model = "upconv_7_anime_style_art_rgb"
            $script:worker = "Waifu2x"
            $script:name = "(waifu2x)(upconv_7_anime_style_art_rgb)"
            $script:params = "-m models-upconv_7_anime_style_art_rgb"
            Waifu2x-CUGAN
        }
        "8" {
            $script:app = $waifu2x
            $script:model = "upconv_7_photo"
            $script:worker = "Waifu2x"
            $script:name = "(waifu2x)(upconv_7_photo)"
            $script:params = "-m models-upconv_7_photo"
            Waifu2x-CUGAN
        }
    }
}
