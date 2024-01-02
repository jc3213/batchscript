$CurrentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([Environment]::Is64BitOperatingSystem) {
    $SystemArch = "x64"
} else {
    $SystemArch = "x86"
}
Add-AppxPackage -Path "$CurrentDir\Microsoft.VCLibs.140.00_14.0.30704.0_$SystemArch__8wekyb3d8bbwe.Appx"
Start-Sleep -Seconds 5
