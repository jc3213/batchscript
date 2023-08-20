@echo off
call :avm1app1 bmp Bitmap
call :avm1app1 dib Bitmap
call :avm1app1 gif Gif
call :avm1app1 jfif JFIF
call :avm1app1 jpe Jpeg
call :avm1app1 jpeg Jpeg
call :avm1app1 jpg Jpeg
call :avm1app1 png Png
call :avm1app1 tiff Tiff
call :avm1app1 tif Tiff
call :avm1app1 wdp Wdp
call :avm1app2 Bitmap 70
call :avm1app2 JFIF 72
call :avm1app2 Jpeg 72
call :avm1app2 Png 71
call :avm1app2 Tiff 122
call :avm1app2 Wdp
call :avm1app4 Bitmap 6
call :avm1app4 JFIF 5
call :avm1app4 Jpeg 5
call :avm1app4 Png 7
call :avm1app4 Tiff 8
call :avm1app5 JFIF
call :avm1app5 Jpeg
call :avm1app5 Wdp
call :avm1app6 JFIF
call :avm1app6 Jpeg
call :avm1app6 Tiff
call :avm1app6 Wdp
timeout /t 5
exit
:avm1app1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".%1" /t "REG_SZ" /d "PhotoViewer.FileAssoc.%2" /f
exit /b
:avm1app2
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
if %1 equ Wdp goto :avm1app3
reg add "HKCR\PhotoViewer.FileAssoc.%1\DefaultIcon" /ve /t "REG_SZ" /d "%%SystemRoot%%\System32\imageres.dll,-%2" /f
exit /b
:avm1app3
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\DefaultIcon" /ve /t "REG_SZ" /d "%%SystemRoot%%\System32\wmphoto.dll,-400" /f
exit /b
:avm1app4
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-305%2" /f
exit /b
:avm1app5
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
exit /b
:avm1app6
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
