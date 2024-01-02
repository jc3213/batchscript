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
            Write-Host "`n`nSample: D:\EdgeUserData"
            $edge_path = Read-Host ">"
            if (Test-Path $edge_path) {
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
            Write-Host "`n`nSample: D:\EdgeUserData"
            $edge_path = Read-Host ">"
            if (Test-Path $edge_path) {
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
            schtasks /change /disable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
        }
        "1" {
            schtasks /change /enable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
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
            
        }
        "2" {
            
        }
        "3" {
            
        }
        "4" {
            
        }
        "5" {
            Manage-MicrosoftEdge
        }
        "6" {
            Manage-MicrosoftDefender
        }
    }
}