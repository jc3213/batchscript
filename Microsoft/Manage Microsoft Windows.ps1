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
    Write-Host "+. Return to Main Menu"
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
    Write-Host "+. Return to Main Menu"
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
            }
        }
        "+" {
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
    Write-Host "+. Return to Main Menu"
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
            }
        }
        "2" {
            Write-Host "`n`nSample: D:\EdgeUserData"
            $edge_path = Read-Host ">"
            if (Test-Path $edge_path) {
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "DiskCacheDir" -Value $edge_path
            }
        }
        "+" {
        }
        default {
            MSEdge-BrowserCachesDirectory
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
        default {
            Manage-MicrosoftEdge
        }
    }
# Will remove when whole script is complete
    Manage-MicrosoftEdge
}

Manage-MicrosoftEdge
