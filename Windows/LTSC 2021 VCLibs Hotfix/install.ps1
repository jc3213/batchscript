if ([Environment]::Is64BitOperatingSystem) {
    $SystemArch = "x64"
} else {
    $SystemArch = "x86"
}
Add-AppxPackage -Path "$PSScriptRoot\Microsoft.VCLibs.140.00_14.0.30704.0_$SystemArch`__8wekyb3d8bbwe.Appx"
Pause
