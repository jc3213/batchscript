Add-Type -AssemblyName System.Windows.Forms

function Manage-WindowsPowerPlan {
    Clear-Host
    Write-Host "Manage Microsoft Edge"
    Write-Host "==============================================================="
    Write-Host "1. Manage System Hibernation"
    Write-Host "2. Manage Disk Idle Timeout"
    Write-Host "3. Manage Processor Maximum P-state"
    Write-Host "4. Manage Processor Minimum P-state"
    Write-Host "5. Manage Heterogeneous Thread Policy"
    Write-Host "+. Return to main menu"
    Write-Host "==============================================================="
    $winpower = Read-Host ">"

    switch ($winpower) {
        "1" {
            Power-ManageHibernation
        }
        "2" {
            Power-DiskIdleTimeout
        }
        "3" {
            Power-MaximumPState
        }
        "4" {
            Power-MinimumPState
        }
        "5" {
            Power-HeterogeneousThread
        }
        "+" {
        }
        default {
            Manage-WindowsPowerPlan
        }
    }
}

function Power-ManageHibernation {
    Clear-Host
    Write-Host "System Hibernation - Power Plan"
    Write-Host "=================================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $power_hibern = Read-Host ">"

    switch ($power_hibern) {
        "0" {
            powercfg /hibernate off
        }
        "1" {
            powercfg /hibernate on
        }
        "+" {
            Manage-WindowsPowerPlan
        }
        default {
            Power-ManageHibernation
        }
    }
}

function Power-DiskIdleTimeout {
    Clear-Host
    Write-Host "Disk Idle Timeout - Power Plan"
    Write-Host "=================================================================="
    Write-Host "0. Never"
    Write-Host "1. Default (20 minutes)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $power_diskout = Read-Host ">"

    switch ($power_diskout) {
        "0" {
            powercfg /change disk-timeout-ac 0
            powercfg /change disk-timeout-dc 0
        }
        "1" {
            powercfg /change disk-timeout-ac 20
            powercfg /change disk-timeout-dc 20
        }
        "+" {
            Manage-WindowsPowerPlan
        }
        default {
            Power-DiskIdleTimeout
        }
    }
}

function Power-MaximumPState {
    Clear-Host
    Write-Host "Processor Maximum P-state - Power Plan"
    Write-Host "=================================================================="
    Write-Host "Minimum: 50"
    Write-Host "Maximum: 100 (Default)"
    Write-Host "=================================================================="
    $power_cpumax = Read-Host ">"

    if ($power_cpumax -match "^[5-9][0-9]$|^100$") {
        $CPU_max=$power_cpumax
    } else {
        $CPU_max="100"
    }

    powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX $CPU_max
    powercfg /setactive scheme_current
}

function Power-MinimumPState {
    Clear-Host
    Write-Host "Processor Minimum P-state - Power Plan"
    Write-Host "=================================================================="
    Write-Host "Minimum: 0 (Default)"
    Write-Host "Maximum: 100"
    Write-Host "=================================================================="
    $power_cpumin = Read-Host ">"

    if ($power_cpumin -match "^[0-9]$|^[1-9][0-9]$|^100$") {
        $CPU_min=$power_cpumin
    } else {
        $CPU_min="0"
    }

    powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN $CPU_min
    powercfg /setactive scheme_current
}

function Power-HeterogeneousThread {
    Clear-Host
    Write-Host "Heterogeneous Thread Policy - Power Plan"
    Write-Host "=================================================================="
    Write-Host "0. Default (Automatic)"
    Write-Host "1. Prefer performant processors"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $power_hetero = Read-Host ">"

    switch ($power_hetero) {
        "0" {
            powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY 5
            powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 5
            powercfg /setactive scheme_current
        }
        "1" {
            powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY 2
            powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 2
            powercfg /setactive scheme_current
        }
        "+" {
            Manage-WindowsPowerPlan
        }
        default {
            Power-HeterogeneousThread
        }
    }
}

function Manage-WindowsUpdate {
    Clear-Host
    Write-Host "Manage Windows Update"
    Write-Host "==============================================================="
    Write-Host "1. Manage Auto Update"
    Write-Host "2. Manage Driver Auto Update"
    Write-Host "3. Manage Windows Update Service (wuauserv)"
    Write-Host "+. Return to Main Menu"
    Write-Host "==============================================================="
    $winupdate = Read-Host ">"

    switch ($winupdate) {
        "1" {
            WinUpdate-AutoUpdate
        }
        "2" {
            WinUpdate-DriverAutoUpdate
        }
        "3" {
            WinUpdate-UpdateService
        }
        "+" {
        }
        default {
            Manage-WindowsUpdate
        }
    }
}

function WinUpdate-AutoUpdate {
    Clear-Host
    Write-Host "Auto Update - Windows Update"
    Write-Host "==============================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $update_autoup = Read-Host ">"

    switch ($update_autoup) {
        "0" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 1
        }
        "1" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate"
        }
        "+" {
            Manage-WindowsUpdate
        }
        default {
            WinUpdate-AutoUpdate
        }
    }
}

function WinUpdate-DriverAutoUpdate {
    Clear-Host
    Write-Host "Driver Auto Update - Windows Update"
    Write-Host "==============================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $update_driver = Read-Host ">"

    switch ($update_driver) {
        "0" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1
        }
        "1" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate"
        }
        "+" {
            Manage-WindowsUpdate
        }
        default {
            WinUpdate-DriverAutoUpdate
        }
    }
}

function WinUpdate-UpdateService {
    Clear-Host
    Write-Host "Windows Update Service - Windows Update"
    Write-Host "==============================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $update_service = Read-Host ">"

    switch ($update_service) {
        "0" {
            Stop-Service -Name "wuauserv" -Force
            Set-Service -Name "wuauserv" -StartupType Disabled
        }
        "1" {
            Set-Service -Name "wuauserv" -StartupType Automatic
            Start-Service -Name "wuauserv"
        }
        "+" {
            Manage-WindowsUpdate
        }
        default {
            WinUpdate-UpdateService
        }
    }
}

function Manage-WindowsMaintenance {
    Clear-Host
    Write-Host "Manage Windows Maintenance"
    Write-Host "==============================================================="
    Write-Host "1. Manage Super Prefetch"
    Write-Host "2. Manage Disk Defragment"
    Write-Host "3. Manage Diagnostic"
    Write-Host "4. Manage Auto Maintenance"
    Write-Host "+. Return to Main Menu"
    Write-Host "==============================================================="
    $winmain = Read-Host ">"

    switch ($winmain) {
        "1" {
            WinMain-SuperPrefetch
        }
        "2" {
            WinMain-DiskDefragment
        }
        "3" {
            WinMain-Diagnostic
        }
        "4" {
            WinMain-AutoMaintenance
        }
        "+" {
        }
        default {
            Manage-WindowsMaintenance
        }
    }
}

function WinMain-SuperPrefetch {
    Clear-Host
    Write-Host "Super Prefetch - Windows Maintenance"
    Write-Host "==============================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $main_prefetch = Read-Host ">"

    switch ($main_prefetch) {
        "0" {
            Stop-Service -Name "SysMain" -Force
            Set-Service -Name "SysMain" -StartupType Disabled
        }
        "1" {
            Set-Service -Name "SysMain" -StartupType Automatic
            Start-Service -Name "SysMain"
        }
        "+" {
            Manage-WindowsMaintenance
        }
        default {
            WinMain-SuperPrefetch
        }
    }
}

function WinMain-DiskDefragment {
    Clear-Host
    Write-Host "Disk Defragment - Windows Maintenance"
    Write-Host "==============================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $main_defrag = Read-Host ">"

    switch ($main_defrag) {
        "0" {
            $task = Get-ScheduledTask -TaskName "\Microsoft\Windows\Defrag\ScheduledDefrag"
            $task.Settings.Enabled = $false
            Set-ScheduledTask -InputObject $task
        }
        "1" {
            $task = Get-ScheduledTask -TaskName "\Microsoft\Windows\Defrag\ScheduledDefrag"
            $task.Settings.Enabled = $true
            Set-ScheduledTask -InputObject $task
        }
        "+" {
            Manage-WindowsMaintenance
        }
        default {
            WinMain-DiskDefragment
        }
    }
}

function WinMain-Diagnostic {
    Clear-Host
    Write-Host "Diagnostic - Windows Maintenance"
    Write-Host "==============================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $main_diag = Read-Host ">"

    switch ($main_diag) {
        "0" {
            $task = Get-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
            $task.Settings.Enabled = $false
            Set-ScheduledTask -InputObject $task
            $task = Get-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
            $task.Settings.Enabled = $false
            Set-ScheduledTask -InputObject $task
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0
            Stop-Service -Name "DiagTrack" -Force
            Set-Service -Name "DiagTrack" -StartupType Disabled
            Stop-Service -Name "DPS" -Force
            Set-Service -Name "DPS" -StartupType Disabled
        }
        "1" {
            $task = Get-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
            $task.Settings.Enabled = $true
            Set-ScheduledTask -InputObject $task
            $task = Get-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
            $task.Settings.Enabled = $true
            Set-ScheduledTask -InputObject $task
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry"
            Set-Service -Name "DiagTrack" -StartupType Automatic
            Start-Service -Name "DiagTrack"
            Set-Service -Name "DPS" -StartupType Automatic
            Start-Service -Name "DPS"
        }
        "+" {
            Manage-WindowsMaintenance
        }
        default {
            WinMain-Diagnostic
        }
    }
}

function WinMain-AutoMaintenance {
    Clear-Host
    Write-Host "Auto Maintenance - Windows Maintenance"
    Write-Host "==============================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $main_automain = Read-Host ">"

    switch ($main_automain) {
        "0" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -Value 1
        }
        "1" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled"
        }
        "+" {
            Manage-WindowsMaintenance
        }
        default {
            WinMain-AutoMaintenance
        }
    }
}

function Manage-WindowsAccessibility {
    Clear-Host
    Write-Host "Windows Accessibility"
    Write-Host "==============================================================="
    Write-Host "1. Move Temporary Files to Ramdisk"
    Write-Host "2. Context Menu (Windows 11)"
    Write-Host "3. Windows Picture Viewer"
    Write-Host "4. CPU Microcode Update"
    Write-Host "+. Return to Main Menu"
    Write-Host "==============================================================="
    $winaccess = Read-Host ">"

    switch ($winaccess) {
        "1" {
            WinAccess-TemporayToRamdisk
        }
        "2" {
            WinAccess-ContextMenu
        }
        "3" {
            WinAccess-PictureViewer
        }
        "4" {
            WinAccess-CpuMicrocodeUpdate
        }
        "+" {
        }
        default {
            Manage-WindowsAccessibility
        }
    }
}

function WinAccess-TemporayToRamdisk {
    Clear-Host
    Write-Host "Move Temporary Files to Ramdisk - Windows Accessibility"
    Write-Host "==============================================================="
    Write-Host "Please wait..."
    Write-Host "==============================================================="

    $ramdisk = Get-WmiObject -Query "SELECT Caption FROM Win32_LogicalDisk WHERE VolumeName='RAMDISK'" | Select-Object -ExpandProperty Caption
    $ramdisk = Join-Path -Path $ramdisk -ChildPath "Temp"

    if (Test-Path $ramdisk) {
        Remove-Item -Path "$env:LOCALAPPDATA\Temp" -Recurse -Force
        Remove-Item -Path "$env:WINDIR\Temp" -Recurse -Force

        New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\Temp" -Value $ramdisk
        New-Item -ItemType Junction -Path "$env:WINDIR\Temp" -Value $ramdisk
    }
}

function WinAccess-ContextMenu {
    Clear-Host
    Write-Host "Context Menu (Windows 11) - Windows Accessibility"
    Write-Host "==============================================================="
    Write-Host "0. Modern Mode (Default)"
    Write-Host "1. Legacy Mode"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $access_ctxmenu = Read-Host ">"

    switch ($access_ctxmenu) {
        "0" {
            Remove-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -ErrorAction SilentlyContinue
        }
        "1" {
            New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force | Out-Null
        }
        "+" {
            Manage-WindowsAccessibility
        }
        default {
            WinAccess-ContextMenu
        }
    }
}

function WinAccess-PictureViewer {
    Clear-Host
    Write-Host "Windows Picture Viewer - Windows Accessibility"
    Write-Host "==============================================================="
    Write-Host "Processing..."
    Write-Host "==============================================================="

    $viewer = Join-Path -Path $PSScriptRoot -ChildPath "Picture Viewer.reg"

    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jc3213/batchscript/main/Windows/Picture%20Viewer/Picture%20Viewer.reg" -OutFile $viewer
    Start-Process -FilePath "regedit.exe" -ArgumentList "/s `"$viewer`"" -Verb RunAs

    Write-Host "Do you want to delete the downloaded `"$viewer`" file? (y/n)"
    $confirm = Read-Host ">"

    if ($confirm -eq "y") {
        Remove-Item -Path $viewer -Force
    }
}

function WinAccess-CpuMicrocodeUpdate {
    Clear-Host
    Write-Host "CPU Microcode Update - Windows Accessibility"
    Write-Host "==============================================================="
    Write-Host "0. Restore from Backup"
    Write-Host "1. Remove and Backup"
    Write-Host "+. Return to Upper Menu"
    Write-Host "==============================================================="
    $avsub = Read-Host ">"

    $amd = Join-Path -Path $env:WINDIR -ChildPath "System32\mcupdate_GenuineIntel.dll"
    $intel = Join-Path -Path $env:WINDIR -ChildPath "System32\mcupdate_AuthenticAMD.dll"
    $admin = New-Object System.Security.Principal.NTAccount("Administrators")
    $mcbk = Join-Path -Path $PSScriptRoot -ChildPath "microcode_backup.zip"

    switch ($avsub) {
        "0" {
            Expand-Archive -Force -Path $mcbk -DestinationPath "$env:WINDIR\System32"
        }
        "1" {
            $acl = Get-Acl -Path $amd
            $acl.SetOwner($admin)
            Set-Acl -Path $amd -AclObject $acl
            $acl = Get-Acl -Path $intel
            $acl.SetOwner($admin)
            Set-Acl -Path $intel -AclObject $acl
            Compress-Archive -Force -Path $amd, $intel -DestinationPath $mcbk
            Remove-Item -Path $amd, $intel -Force
        }
        "+" {
            Manage-WindowsAccessibility
        }
        default {
            WinAccess-CpuMicrocodeUpdate
        }
    }
}

function Manage-MicrosoftEdge {
    Clear-Host
    Write-Host "Manage Microsoft Edge"
    Write-Host "==============================================================="
    Write-Host "1. Bing Discovery Button"
    Write-Host "2. Desktop Search Bar"
    Write-Host "3. Alt + Tab Behavior"
    Write-Host "4. User Profile Directory"
    Write-Host "5. Browser Caches Directory"
    Write-Host "+. Return to main menu"
    Write-Host "==============================================================="
    $msedge = Read-Host ">"

    switch ($msedge) {
        "1" {
            MSEdge-BingDiscoveryButton
        }
        "2" {
            MSEdge-DesktopSearchBar
        }
        "3" {
            MSEdge-AltTabBehavior
        }
        "4" {
            MSEdge-UserProfileDirectory
        }
        "5" {
            MSEdge-BrowserCachesDirectory
        }
        "+" {
        }
        default {
            Manage-MicrosoftEdge
        }
    }
}

function MSEdge-BingDiscoveryButton {
    Clear-Host
    Write-Host "Manage Bing Discovery Button - Microsoft Edge"
    Write-Host "=================================================================="
    Write-Host "0. Hide"
    Write-Host "1. Show (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $edge_bing = Read-Host ">"
    switch ($edge_bing) {
        "0" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HubsSidebarEnabled" -Value 0
        }
        "1" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HubsSidebarEnabled"
        }
        "+" {
            Manage-MicrosoftEdge
        }
        default {
            MSEdge-BingDiscoveryButton
        }
    }
}

function MSEdge-DeskTopSearchBar {
    Clear-Host
    Write-Host "Manage Bing Discovery Button - Microsoft Edge"
    Write-Host "=================================================================="
    Write-Host "0. Hide"
    Write-Host "1. Show (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $edge_search = Read-Host ">"
    switch ($edge_search) {
        "0" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "WebWidgetAllowed" -Value 0
        }
        "1" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "WebWidgetAllowed"
        }
        "+" {
            Manage-MicrosoftEdge
        }
        default {
            MSEdge-DesktopSearchBar
        }
    }
}

function MSEdge-AltTabBehavior {
    Clear-Host
    Write-Host "Manage Alt + Tab Behavior - Microsoft Edge"
    Write-Host "=================================================================="
    Write-Host "0. Default"
    Write-Host "1. Switch only via windows"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $edge_shortcut = Read-Host ">"
    switch ($edge_shortcut) {
        "0" {
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingegmenu3Filter" -Value 0
        }
        "1" {
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingegmenu3Filter" -Value 3
        }
        "+" {
            Manage-MicrosoftEdge
        }
        default {
            MSEdge-AltTabBehavior
        }
    }
}

function MSEdge-UserProfileDirectory {
    Clear-Host
    Write-Host "Manage User Profile Directory - Microsoft Edge"
    Write-Host "=================================================================="
    Write-Host "0. Default"
    Write-Host "1. Move to Documents"
    Write-Host "2. Move to User Directory"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $edge_profile = Read-Host ">"
    switch ($edge_profile) {
        "0" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "UserDataDir"
        }
        "1" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "UserDataDir" -Value "$env:UserProfile\Documents\EdgeUserData"
        }
        "2" {
            $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
            $result = $dialog.ShowDialog()
            if ($result -eq "OK") {
                $edge_path = $dialog.SelectedPath
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "UserDataDir" -Value $edge_path
            } else {
                MSEdge-UserProfileDirectory
            }
        }
        "+" {
            Manage-MicrosoftEdge
        }
        default {
            MSEdge-UserProfileDirectory
        }
    }
}

function MSEdge-BrowserCachesDirectory {
    Clear-Host
    Write-Host "Manage Browser Caches Directory - Microsoft Edge"
    Write-Host "=================================================================="
    Write-Host "0. Default"
    Write-Host "1. Move to RAMDISK"
    Write-Host "2. Move to User Directory"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $edge_ramdisk = Read-Host ">"
    switch ($edge_ramdisk) {
        "0" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "DiskCacheDir"
        }
        "1" {
            $ramdisk = Get-WmiObject -Query "SELECT Caption FROM Win32_LogicalDisk WHERE VolumeName='RAMDISK'" | Select-Object -ExpandProperty Caption
            $ramdisk = Join-Path -Path $ramdisk -ChildPath "Temp"
            if (Test-Path $ramdisk) {
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "DiskCacheDir" -Value $ramdisk
            } else {
                MSEdge-BrowserCachesDirectory
            }
        }
        "2" {
            $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
            $result = $dialog.ShowDialog()
            if ($result -eq "OK") {
                $edge_path = $dialog.SelectedPath
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "DiskCacheDir" -Value $edge_path
            } else {
                MSEdge-BrowserCachesDirectory
            }
        }
        "+" {
            Manage-MicrosoftEdge
        }
        default {
            MSEdge-BrowserCachesDirectory
        }
    }
}

function Manage-MicrosoftDefender {
    Clear-Host
    Write-Host "Manage Microsoft Defender"
    Write-Host "==============================================================="
    Write-Host "1. Manage Real-time Protection"
    Write-Host "2. Manage Scheduled Scan"
    Write-Host "3. Manage Context Menu"
    Write-Host "4. Manage System Tray Icon"
    Write-Host "==============================================================="
    $msdefender = Read-Host ">"

    switch ($msdefender) {
        "1" {
            MSDefender-RealtimeProtection
        }
        "2" {
            MSDefender-ScheduledScan
        }
        "3" {
            MSDefender-ContextMenu
        }
        "4" {
            MSDefender-SystemTrayIcon
        }
        "+" {
        }
        default {
            Manage-MicrosoftDefender
        }
    }
}

function MSDefender-RealtimeProtection {
    Clear-Host
    Write-Host "Real-time Protection - Windows Defender"
    Write-Host "=================================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $defender_realtime = Read-Host ">"

    switch ($defender_realtime) {
        "0" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Value 1
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableBehaviorMonitoring" -Value 1
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableScanOnRealtimeEnable" -Value 1
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" -Name "Start" -Value 4
        }
        "1" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware"
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" -Name "Start" -Value 2
        }
        "+" {
            Manage-MicrosoftDefender
        }
        default {
            MSDefender-RealtimeProtection
        }
    }
}

function MSDefender-ScheduledScan {
    Clear-Host
    Write-Host "Scheduled Scan - Windows Defender"
    Write-Host "=================================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $defender_autoscan = Read-Host ">"

    switch ($defender_autoscan) {
        "0" {
            $task = Get-ScheduledTask -TaskName "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
            $task.Settings.Enabled = $false
            Set-ScheduledTask -InputObject $task
        }
        "1" {
            $task = Get-ScheduledTask -TaskName "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
            $task.Settings.Enabled = $true
            Set-ScheduledTask -InputObject $task
        }
        "+" {
            Manage-MicrosoftDefender
        }
        default {
            MSDefender-ScheduledScan
        }
    }
}

function MSDefender-ContextMenu {
    Clear-Host
    Write-Host "Context Menu - Windows Defender"
    Write-Host "=================================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $defender_ctxmenu = Read-Host ">"

    switch ($defender_ctxmenu) {
        "0" {
            Remove-ItemProperty -Path "HKCR:\*\shellex\ContextMenuHandlers\EPP"
            Remove-ItemProperty -Path "HKCR:\Drive\shellex\ContextMenuHandlers\EPP"
            Remove-ItemProperty -Path "HKCR:\Directory\shellex\ContextMenuHandlers\EPP"
            Remove-ItemProperty -Path "HKCR:\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32"
        }
        "1" {
            Set-ItemProperty -Path "HKCR:\*\shellex\ContextMenuHandlers\EPP" -Value "{09A47860-11B0-4DA5-AFA5-26D86198A780}"
            Set-ItemProperty -Path "HKCR:\Drive\shellex\ContextMenuHandlers\EPP" -Value "{09A47860-11B0-4DA5-AFA5-26D86198A780}"
            Set-ItemProperty -Path "HKCR:\Directory\shellex\ContextMenuHandlers\EPP" -Value "{09A47860-11B0-4DA5-AFA5-26D86198A780}"
            Set-ItemProperty -Path "HKCR:\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" -Value "$env:ProgramFiles\Windows Defender\shellext.dll"
        }
        "+" {
            Manage-MicrosoftDefender
        }
        default {
            MSDefender-ContextMenu
        }
    }
}

function MSDefender-SystemTrayIcon {
    Clear-Host
    Write-Host "System Tray Icon - Windows Defender"
    Write-Host "=================================================================="
    Write-Host "0. Disable"
    Write-Host "1. Enable (Default)"
    Write-Host "+. Return to Upper Menu"
    Write-Host "=================================================================="
    $defender_trayicon = Read-Host ">"

    switch ($defender_trayicon) {
        "0" {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Name "HideSystray" -Value 1
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" -Name "SecurityHealth" -Value ([byte[]](7,0,0,0,205,84,246,153,209,97,217,0))
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth"
        }
        "1" {
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Name "HideSystray"
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" -Name "SecurityHealth"
        }
        "+" {
            Manage-MicrosoftDefender
        }
        default {
            MSDefender-SystemTrayIcon
        }
    }
}

while ($true) {
    Clear-Host
    Write-Host "Manage Microsoft Windows"
    Write-Host "=================================================================="
    Write-Host "1. Windows Power Plan"
    Write-Host "2. Windows Update"
    Write-Host "3. Windows Maintenance"
    Write-Host "4. Windows Accessibility"
    Write-Host "5. Microsoft Edge"
    Write-Host "6. Microsoft Defender"
    Write-Host "=================================================================="
    $main = Read-Host ">"
    
    switch($main) {
        "1" {
            Manage-WindowsPowerPlan
        }
        "2" {
            Manage-WindowsUpdate
        }
        "3" {
            Manage-WindowsMaintenance
        }
        "4" {
            Manage-WindowsAccessibility
        }
        "5" {
            Manage-MicrosoftEdge
        }
        "6" {
            Manage-MicrosoftDefender
        }
    }
}
