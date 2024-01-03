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

function Real-ESRGAN {
    Set-Format
    Get-Files
    foreach ($file in $script:files) {
        Write-Host "`n`nReal-ESRGAN is processing: `"$file`""
        $folder = Split-Path -Path $file -Parent
        $name = [System.IO.Path]::GetFileNameWithoutExtension($file) + "$script:name.$script:format"
        $output = "$folder\$name"
        Start-Process -FilePath $realesrgan -ArgumentList "-i `"$file`" -o `"$output`" $script:params" -Wait -WindowStyle Hidden
        Write-Host "Output file: `"$output`""
    }
    Pause
}

function Waifu-2x {
    Set-Format
    Get-Files
    foreach ($file in $script:files) {
        Write-Host "`n`nWaifu2x is processing: `"$file`""
        $folder = Split-Path -Path $file -Parent
        $name = [System.IO.Path]::GetFileNameWithoutExtension($file) + "$script:name.$script:format"
        $output = "$folder\$name"
        Start-Process -FilePath $waifu2x -ArgumentList "-i `"$file`" -o `"$output`" $script:params" -Wait -WindowStyle Hidden
        Write-Host "Output file: `"$output`""
    }
    Pause
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
    $model = Read-Host "> "
    switch ($model) {
        "1" {
            $script:name = "(real-esrgan)(x4plus)(4x)"
            $script:params = "-m realesrgan-x4plus"
            Real-ESRGAN
        }
        "2" {
            $script:name = "(real-esrgan))(x4plus-anime)(4x)"
            $script:params = "-m realesrgan-x4plus-anime"
            Real-ESRGAN
        }
        "3" {
            $script:name = "(real-esrgan)(animevideov3)"
            $script:params = "-m realesr-animevideov3"
            Set-Scale
            Real-ESRGAN
        }
        "4" {
            $script:name = "(waifu2x)(cu-net)"
            $script:params = "-m models-cunet"
            Set-Scale
            Set-Denoise
            Waifu-2x
        }
        "4" {
            $script:name = "(waifu2x)(upconv_7_anime_style_art_rgb)"
            $script:params = "-m models-upconv_7_anime_style_art_rgb"
            Set-Scale
            Set-Denoise
            Waifu-2x
        }
        "4" {
            $script:name = "(waifu2x)(upconv_7_photo)"
            $script:params = "-m models-upconv_7_photo"
            Set-Scale
            Set-Denoise
            Waifu-2x
        }
    }
}
