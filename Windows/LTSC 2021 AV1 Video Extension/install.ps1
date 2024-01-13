$CurrentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([Environment]::Is64BitOperatingSystem) {
    $SystemArch = "x64"
} else {
    $SystemArch = "x86"
}
Add-AppxPackage -Path "$CurrentDir\Microsoft.AV1VideoExtension_1.1.52851.0_$SystemArch`__8wekyb3d8bbwe.Appx"
Pause
