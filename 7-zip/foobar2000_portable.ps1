$7zip = (Get-ItemProperty -Path "HKLM:\Software\7-Zip" -Name "Path").Path + "7z.exe"
$response = Invoke-WebRequest -Uri "https://www.foobar2000.org/download"
$download = $response.Content | Select-String -Pattern 'foobar2000(-x64|-arm64ec)?_v[^"]+\.exe' -AllMatches
$result = $download.Matches.Value[0..2]

function Make-Portable ($name) {
    $link = "https://www.foobar2000.org/files/getfile/$name"
    $file = "$PSScriptRoot\$name"
    $portable = "$PSScriptRoot\" + [System.IO.Path]::GetFileNameWithoutExtension($file)

    Clear-Host
    Write-Host "Downloading: $link"

    if (!(Test-Path $file)) {
        Invoke-WebRequest -Uri $link -OutFile $file
    }

    Write-Host "Extracting: $file"

    Start-Process -FilePath $7zip -ArgumentList "x $file -y -x`!`$PLUGINSDIR -x`!`$R0 -x`!uninstall.exe -o$portable" -WindowStyle Hidden -Wait

    Write-Host "Portable: $portable"

    New-Item -Path "$portable\portable_mode_enabled" -ItemType File -Force | Out-Null
    Invoke-Item -Path $portable
}

while ($true) {
    Write-Host "============================================================="
    Write-Host "1. x86    :   $($result[0])"
    Write-Host "2. x86-64 :   $($result[1])"
    Write-Host "3. ARM64  :   $($result[2])"
    Write-Host "============================================================="

    $choice = Read-Host ">"

    if ($choice -ge 1 -and $choice -le 3) {
        Make-Portable $result[$choice - 1]
        break
    }
}
