Add-Type -AssemblyName System.Windows.Forms
$Zip = (Get-ItemProperty -Path "HKLM:\Software\7-Zip").Path + "\7z.exe"

function Get-Files ($bool) {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Multiselect = $true
    $dialog.Filter = "Compressed files|*.zip;*.rar;*.7z;*.lzh;"
    $result = $dialog.ShowDialog()

    if ($result -eq "OK") {
        foreach ($file in $dialog.FileNames) {
            $name = [System.IO.Path]::GetFileNameWithoutExtension($file)
            $ext = [System.IO.Path]::GetExtension($file)
            $folder = (Split-Path -Path $file -Parent) + "\$name"
            $output = $folder + ".zip"
            Write-Host "`n`n7-zip is processing: `"$file`""
            Start-Process -FilePath $Zip -ArgumentList "x `"$file`" -o`"$folder`" -aoa" -Wait -WindowStyle Hidden
            Start-Process -FilePath $Zip -ArgumentList "a `"$output`" `"$folder\*`"" -Wait -WindowStyle Hidden
            Write-Host "Output file: `"$output`""
            if ($bool -eq "y") {
                Remove-Item -Path "$folder" -Recurse -Force
                if ($ext -ne "zip") {
                    Remove-Item -Path "$file" -Force
                }
            }
        }
    }

    $restart = Get-Restart
    if ($restart -ne "y") {
        Get-Files "$bool"
    }
}

function Get-Directory ($bool) {
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $result = $dialog.ShowDialog()
    if ($result -eq "OK") {
        $folder = $dialog.SelectedPath
        $output = $folder + ".zip"
        Write-Host "`n`n`7-zip is processing: `"$folder`""
        Start-Process -FilePath $Zip -ArgumentList "a `"$output`" `"$folder\*`"" -Wait -WindowStyle Hidden
        Write-Host "Output file: `"$output`""
        if ($bool -eq "y") {
            Remove-Item -Path "$folder" -Recurse -Force
        }
    }
    
    $restart = Get-Restart
    if ($restart -ne "y") {
        Get-Directory "$bool"
    }
}

function Get-Restart {
    Write-Host "`n`nGo back and restart the utilities?"
    Write-Host "=================================================================="
    Write-Host "Yes [y]"
    Write-Host "No [n] (Default)"
    Write-Host "=================================================================="
    return Read-Host ">"
}

while ($true) {
    Clear-Host
    Write-Host "Recompress or convert to zip?"
    Write-Host "=================================================================="
    Write-Host "Yes [y] (Default) "
    Write-Host "No [n]"
    Write-Host "=================================================================="
    $compress = Read-Host ">"

    Write-Host "`n`nRemove original files or temporary files?"
    Write-Host "=================================================================="
    Write-Host "Yes [y] (Default)"
    Write-Host "No [n]"
    Write-Host "=================================================================="
    $remove = Read-Host ">"

    if ($remove -ne "n") {
        $remove = "y"
    }

    if ($compress -ne "n") {
        Get-Files "$remove"
    } else {
        Get-Directory "$remove"
    }
}
