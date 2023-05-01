@echo off
set FileExt=HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations
::
set FileBmp=PhotoViewer.FileAssoc.Bitmap
set FileJfif=PhotoViewer.FileAssoc.JFIF
set FileJpeg=PhotoViewer.FileAssoc.Jpeg
set FileGif=PhotoViewer.FileAssoc.Gif
set FilePng=PhotoViewer.FileAssoc.Png
set FileTiff=PhotoViewer.FileAssoc.Tiff
set FileWdp=PhotoViewer.FileAssoc.Wdp
::
set PhotoViewer=^%%ProgramFiles^%%\Windows Photo Viewer\PhotoViewer.dll
set ImgIcon=^%%SystemRoot^%%\System32\imageres.dll
set WdpIcon=^%%SystemRoot^%%\System32\wmphoto.dll
set MuiVerb=@^%%ProgramFiles^%%\Windows Photo Viewer\photoviewer.dll,-3043
set DropTarget={FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}
set OpenCommand=^%%SystemRoot^%%\System32\rundll32.exe \"%PhotoViewer%\", ImageView_Fullscreen ^%%1
::File Associations
reg add "%FileExt%" /v ".bmp" /t "REG_SZ" /d "%FileBmp%" /f
reg add "%FileExt%" /v ".dib" /t "REG_SZ" /d "%FileBmp%" /f
reg add "%FileExt%" /v ".gif" /t "REG_SZ" /d "%FileGif%" /f
reg add "%FileExt%" /v ".jfif" /t "REG_SZ" /d "%FileJfif%" /f
reg add "%FileExt%" /v ".jpe" /t "REG_SZ" /d "%FileJpeg%" /f
reg add "%FileExt%" /v ".jpeg" /t "REG_SZ" /d "%FileJpeg%" /f
reg add "%FileExt%" /v ".jpg" /t "REG_SZ" /d "%FileJpeg%" /f
reg add "%FileExt%" /v ".png" /t "REG_SZ" /d "%FilePng%" /f
reg add "%FileExt%" /v ".tiff" /t "REG_SZ" /d "%FileTiff%" /f
reg add "%FileExt%" /v ".tif" /t "REG_SZ" /d "%FileTiff%" /f
reg add "%FileExt%" /v ".wdp" /t "REG_SZ" /d "%FileWdp%" /f
::File Bmp
reg add "HKCR\%FileBmp%" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%PhotoViewer%,-3056" /f
reg add "HKCR\%FileBmp%" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\%FileBmp%\DefaultIcon" /ve /t "REG_SZ" /d "%ImgIcon%,-70" /f
reg add "HKCR\%FileBmp%\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%OpenCommand%" /f
reg add "HKCR\%FileBmp%\shell\open\DropTarget" /v "Clsid" /t  "REG_SZ" /d "%DropTarget%" /f
::File Jfif
reg add "HKCR\%FileJfif%" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
reg add "HKCR\%FileJfif%" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%PhotoViewer%,-3055" /f
reg add "HKCR\%FileJfif%" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\%FileJfif%\DefaultIcon" /ve /t "REG_SZ" /d "%ImgIcon%,-72" /f
reg add "HKCR\%FileJfif%\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "%MuiVerb%" /f
reg add "HKCR\%FileJfif%\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%OpenCommand%" /f
reg add "HKCR\%FileJfif%\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "%DropTarget%" /f
::File Jpeg
reg add "HKCR\%FileJpeg%" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
reg add "HKCR\%FileJpeg%" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%PhotoViewer%,-3055" /f
reg add "HKCR\%FileJpeg%" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\%FileJpeg%\DefaultIcon" /ve /t "REG_SZ" /d "%ImgIcon%,-72" /f
reg add "HKCR\%FileJpeg%\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "%MuiVerb%" /f
reg add "HKCR\%FileJpeg%\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%OpenCommand%" /f
reg add "HKCR\%FileJpeg%\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "%DropTarget%" /f
::File Png
reg add "HKCR\%FilePng%" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%PhotoViewer%,-3057" /f
reg add "HKCR\%FilePng%" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\%FilePng%\DefaultIcon" /ve /t "REG_SZ" /d "%ImgIcon%,-71" /f
reg add "HKCR\%FilePng%\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%OpenCommand%" /f
reg add "HKCR\%FilePng%\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "%DropTarget%" /f
::File Tiff
reg add "HKCR\%FileTiff%" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%PhotoViewer%,-3058" /f
reg add "HKCR\%FileTiff%" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\%FileTiff%\DefaultIcon" /ve /t "REG_SZ" /d "%ImgIcon%,-122" /f
reg add "HKCR\%FileTiff%\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "%MuiVerb%" /f
reg add "HKCR\%FileTiff%\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%OpenCommand%" /f
reg add "HKCR\%FileTiff%\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "%DropTarget%" /f
::File Wdp
reg add "HKCR\%FileWdp%" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
reg add "HKCR\%FileWdp%" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\%FileWdp%\DefaultIcon" /ve /t "REG_SZ" /d "%WdpIcon%,-400" /f
reg add "HKCR\%FileWdp%\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "%MuiVerb%" /f
reg add "HKCR\%FileWdp%\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%OpenCommand%" /f
reg add "HKCR\%FileWdp%\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "%DropTarget%" /f
::End
timeout /t 5
