$realesrgan = Join-Path $PSScriptRoot "bin\realesrgan-ncnn-vulkan.exe"
$waifu2x = Join-Path $PSScriptRoot "bin\waifu2x-ncnn-vulkan.exe"

function Set-Format {
    Write-Host "`n`nOutput Format"
    Write-Host "============================================================"
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

function Set-Scale {
    Write-Host "`n`nScale Ratio"
    Write-Host "`============================================================"
    Write-Host "1. 2x (Default)"
    Write-Host "2. 4x"
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
    Write-Host "`n`nDenoise Level"
    Write-Host "`============================================================"
    Write-Host "Denoise Level: 0-3"
    Write-Host "Default: 0"
    Write-Host "============================================================"
    $denoise = Read-Host ">"
    if ($denoise -notmatch "^[0-3]$") {
        $denoise = "0"
    }
    $script:name += "(Lv.$denoise)"
    $script:params += " -n $denoise"
    $script:denoise = $denoise
    Set-TTA
}

function Set-TTA {
    Write-Host "`n`nTTA Mode"
    Write-Host "`============================================================"
    Write-Host "1. Enable"
    Write-Host "============================================================"
    $tta = Read-Host ">"
    if ($tta -eq "1") {
        $script:name += "(TTA)"
        $script:params += " -x"
        $script:tta = $true
    }
}

function Get-Files {
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Multiselect = $true
    $dialog.Filter = "Image files|*.jpg;*.png;*.avif;*.webp;*."
    $result = $dialog.ShowDialog()

    if ($result -eq "OK") {
        $script:files = $dialog.FileNames
    }
}

function Real-ESRGAN {
    Set-Format
    Get-Files
    Upscale-Output
}

function Waifu-2x {
    Set-Scale
    Set-Denoise
    Set-Format
    Get-Files
    Upscale-Output
}

function Upscale-Output {
    Write-Host "`n`nUpscaler     :   $script:worker"
    Write-Host "Model        :   $script:model"
    Write-Host "Scale Ratio  :   $script:scale`x"
    foreach ($file in $script:files) {
        Write-Host "`n`nProcessing: `"$file`""
        $folder = Split-Path -Path $file -Parent
        $name = [System.IO.Path]::GetFileNameWithoutExtension($file) + " $script:name.$script:format"
        $output = "$folder$name"
        Start-Process -FilePath $script:app -ArgumentList "-i `"$file`" -o `"$output`" $script:params" -Wait -WindowStyle Hidden
        Write-Host "Output file: `"$output`""
    }
    Pause
}

while ($true) {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "1. Real-ESRGAN Plus"
    Write-Host "2. Real-ESRGAN Plus Anime"
    Write-Host "3. Real-ESRGAN Anime Video v3"
    Write-Host "4. Waifu2x CUnet"
    Write-Host "5. Waifu2x Up-convert RGB"
    Write-Host "6. Waifu2x Up-convert Photo"
    Write-Host "============================================================"
    $model = Read-Host ">"
    switch ($model) {
        "1" {
            $script:app = $realesrgan
            $script:model = "x4plus"
            $script:scale = "4"
            $script:worker = "Real-ESRGAN"
            $script:name = "(real-esrgan)(x4plus)(4x)"
            $script:params = "-n realesrgan-x4plus"
            Real-ESRGAN
        }
        "2" {
            $script:app = $realesrgan
            $script:model = "x4plus-anime"
            $script:scale = "4"
            $script:worker = "Real-ESRGAN"
            $script:name = "(real-esrgan))(x4plus-anime)(4x)"
            $script:params = "-n realesrgan-x4plus-anime"
            Real-ESRGAN
        }
        "3" {
            $script:app = $realesrgan
            $script:model = "animevideov3"
            $script:worker = "Real-ESRGAN"
            $script:name = "(real-esrgan)(animevideov3)"
            $script:params = "-n realesr-animevideov3"
            Set-Scale
            Real-ESRGAN
        }
        "4" {
            $script:app = $waifu2x
            $script:model = "cunet"
            $script:worker = "Waifu2x"
            $script:name = "(waifu2x)(cunet)"
            $script:params = "-m models-cunet"
            Waifu-2x
        }
        "5" {
            $script:app = $waifu2x
            $script:model = "upconv_7_anime_style_art_rgb"
            $script:worker = "Waifu2x"
            $script:name = "(waifu2x)(upconv_7_anime_style_art_rgb)"
            $script:params = "-m models-upconv_7_anime_style_art_rgb"
            Waifu-2x
        }
        "6" {
            $script:app = $waifu2x
            $script:model = "upconv_7_photo"
            $script:worker = "Waifu2x"
            $script:name = "(waifu2x)(upconv_7_photo)"
            $script:params = "-m models-upconv_7_photo"
            Waifu-2x
        }
    }
}
