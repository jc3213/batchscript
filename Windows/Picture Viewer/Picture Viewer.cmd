@echo off
set viewasso="bmp Bitmap" "dib Bitmap" "gif Gif" "jfif JFIF" "jpe Jpeg" "jpeg Jpeg" "jpg Jpeg" "png Png" "tiff Tiff" "tif Tiff" "wdp Wdp"
for %%a in (%viewasso%) do (for /f "tokens=1-2 delims= " %%i in (%%a) do (call :miscm1asso %%i %%j))
set viewcomm="Bitmap imageres 70" "JFIF imageres 72" "Jpeg imageres 72" "Png imageres 71" "Tiff imageres 122" "Wdp wmphoto -400"
for %%a in (%viewcomm%) do (for /f "tokens=1-3 delims= " %%i in (%%a) do (call :miscm1comm %%i %%j %%k))
set viewicon="Bitmap 6" "JFIF 5" "Jpeg 5" "Png 7" "Tiff 8"
for %%a in (%viewicon%) do (for /f "tokens=1-2 delims= " %%i in (%%a) do (call :miscm1name %%i %%j))
for %%a in (JFIF Jpeg Wdp) do (call :miscm1edit %%a)
for %%a in (JFIF Jpeg Tiff Wdp) do (call :miscm1open %%a)
timeout /5
exit
:miscm1asso
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".%1" /t "REG_SZ" /d "PhotoViewer.FileAssoc.%2" /f
exit /b
:miscm1comm
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\DefaultIcon" /ve /t "REG_SZ" /d "%%SystemRoot%%\System32\%2.dll,%3" /f
exit /b
:miscm1name
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-305%2" /f
exit /b
:miscm1edit
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
exit /b
:miscm1open
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
