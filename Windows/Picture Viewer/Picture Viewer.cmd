@ECHO OFF
SET FileExt=HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations
::
SET FileBmp=PhotoViewer.FileAssoc.Bitmap
SET FileJfif=PhotoViewer.FileAssoc.JFIF
SET FileJpeg=PhotoViewer.FileAssoc.Jpeg
SET FileGif=PhotoViewer.FileAssoc.Gif
SET FilePng=PhotoViewer.FileAssoc.Png
SET FileTiff=PhotoViewer.FileAssoc.Tiff
SET FileWdp=PhotoViewer.FileAssoc.Wdp
::
SET PhotoViewer=^%%ProgramFiles^%%\Windows Photo Viewer\PhotoViewer.dll
SET ImgIcon=^%%SystemRoot^%%\System32\imageres.dll
SET WdpIcon=^%%SystemRoot^%%\System32\wmphoto.dll
SET MuiVerb=@^%%ProgramFiles^%%\Windows Photo Viewer\photoviewer.dll,-3043
SET DropTarget={FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}
SET OpenCommand=^%%SystemRoot^%%\System32\rundll32.exe \"%PhotoViewer%\", ImageView_Fullscreen ^%%1
::File Associations
REG ADD "%FileExt%" /V ".bmp" /T "REG_SZ" /D "%FileBmp%" /F
REG ADD "%FileExt%" /V ".dib" /T "REG_SZ" /D "%FileBmp%" /F
REG ADD "%FileExt%" /V ".gif" /T "REG_SZ" /D "%FileGif%" /F
REG ADD "%FileExt%" /V ".jfif" /T "REG_SZ" /D "%FileJfif%" /F
REG ADD "%FileExt%" /V ".jpe" /T "REG_SZ" /D "%FileJpeg%" /F
REG ADD "%FileExt%" /V ".jpeg" /T "REG_SZ" /D "%FileJpeg%" /F
REG ADD "%FileExt%" /V ".jpg" /T "REG_SZ" /D "%FileJpeg%" /F
REG ADD "%FileExt%" /V ".png" /T "REG_SZ" /D "%FilePng%" /F
REG ADD "%FileExt%" /V ".tiff" /T "REG_SZ" /D "%FileTiff%" /F
REG ADD "%FileExt%" /V ".tif" /T "REG_SZ" /D "%FileTiff%" /F
REG ADD "%FileExt%" /V ".wdp" /T "REG_SZ" /D "%FileWdp%" /F
::File Bmp
REG ADD "HKCR\%FileBmp%" /V "FriendlyTypeName" /T "REG_EXPAND_SZ" /D "@%PhotoViewer%,-3056" /F
REG ADD "HKCR\%FileBmp%" /V "ImageOptionFlags" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKCR\%FileBmp%\DefaultIcon" /VE /T "REG_SZ" /D "%ImgIcon%,-70" /F
REG ADD "HKCR\%FileBmp%\shell\open\command" /VE /T "REG_EXPAND_SZ" /D "%OpenCommand%" /F
REG ADD "HKCR\%FileBmp%\shell\open\DropTarget" /V "Clsid" /T  "REG_SZ" /D "%DropTarget%" /F
::File Jfif
REG ADD "HKCR\%FileJfif%" /V "EditFlags" /T "REG_DWORD" /D "0x00010000" /F
REG ADD "HKCR\%FileJfif%" /V "FriendlyTypeName" /T "REG_EXPAND_SZ" /D "@%PhotoViewer%,-3055" /F
REG ADD "HKCR\%FileJfif%" /V "ImageOptionFlags" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKCR\%FileJfif%\DefaultIcon" /VE /T "REG_SZ" /D "%ImgIcon%,-72" /F
REG ADD "HKCR\%FileJfif%\shell\open" /V "MuiVerb" /T "REG_EXPAND_SZ" /D "%MuiVerb%" /F
REG ADD "HKCR\%FileJfif%\shell\open\command" /VE /T "REG_EXPAND_SZ" /D "%OpenCommand%" /F
REG ADD "HKCR\%FileJfif%\shell\open\DropTarget" /V "Clsid" /T "REG_SZ" /D "%DropTarget%" /F
::File Jpeg
REG ADD "HKCR\%FileJpeg%" /V "EditFlags" /T "REG_DWORD" /D "0x00010000" /F
REG ADD "HKCR\%FileJpeg%" /V "FriendlyTypeName" /T "REG_EXPAND_SZ" /D "@%PhotoViewer%,-3055" /F
REG ADD "HKCR\%FileJpeg%" /V "ImageOptionFlags" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKCR\%FileJpeg%\DefaultIcon" /VE /T "REG_SZ" /D "%ImgIcon%,-72" /F
REG ADD "HKCR\%FileJpeg%\shell\open" /V "MuiVerb" /T "REG_EXPAND_SZ" /D "%MuiVerb%" /F
REG ADD "HKCR\%FileJpeg%\shell\open\command" /VE /T "REG_EXPAND_SZ" /D "%OpenCommand%" /F
REG ADD "HKCR\%FileJpeg%\shell\open\DropTarget" /V "Clsid" /T "REG_SZ" /D "%DropTarget%" /F
::File Png
REG ADD "HKCR\%FilePng%" /V "FriendlyTypeName" /T "REG_EXPAND_SZ" /D "@%PhotoViewer%,-3057" /F
REG ADD "HKCR\%FilePng%" /V "ImageOptionFlags" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKCR\%FilePng%\DefaultIcon" /VE /T "REG_SZ" /D "%ImgIcon%,-71" /F
REG ADD "HKCR\%FilePng%\shell\open\command" /VE /T "REG_EXPAND_SZ" /D "%OpenCommand%" /F
REG ADD "HKCR\%FilePng%\shell\open\DropTarget" /V "Clsid" /T "REG_SZ" /D "%DropTarget%" /F
::File Tiff
REG ADD "HKCR\%FileTiff%" /V "FriendlyTypeName" /T "REG_EXPAND_SZ" /D "@%PhotoViewer%,-3058" /F
REG ADD "HKCR\%FileTiff%" /V "ImageOptionFlags" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKCR\%FileTiff%\DefaultIcon" /VE /T "REG_SZ" /D "%ImgIcon%,-122" /F
REG ADD "HKCR\%FileTiff%\shell\open" /V "MuiVerb" /T "REG_EXPAND_SZ" /D "%MuiVerb%" /F
REG ADD "HKCR\%FileTiff%\shell\open\command" /VE /T "REG_EXPAND_SZ" /D "%OpenCommand%" /F
REG ADD "HKCR\%FileTiff%\shell\open\DropTarget" /V "Clsid" /T "REG_SZ" /D "%DropTarget%" /F
::File Wdp
REG ADD "HKCR\%FileWdp%" /V "EditFlags" /T "REG_DWORD" /D "0x00010000" /F
REG ADD "HKCR\%FileWdp%" /V "ImageOptionFlags" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKCR\%FileWdp%\DefaultIcon" /VE /T "REG_SZ" /D "%WdpIcon%,-400" /F
REG ADD "HKCR\%FileWdp%\shell\open" /V "MuiVerb" /T "REG_EXPAND_SZ" /D "%MuiVerb%" /F
REG ADD "HKCR\%FileWdp%\shell\open\command" /VE /T "REG_EXPAND_SZ" /D "%OpenCommand%" /F
REG ADD "HKCR\%FileWdp%\shell\open\DropTarget" /V "Clsid" /T "REG_SZ" /D "%DropTarget%" /F
::End
TIMEOUT /T 5
