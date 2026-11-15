@echo off
setlocal enabledelayedexpansion
pushd %~dp0

for /r %%i in (*_video.*) do (
    echo Find Video: %%i
    set "vid_path=%%i"
    set "vid_dir=%%~dpi"
    set "vid_name=%%~ni"
    set "base_key=!vid_name:_video=!"

    for %%a in ("!base_key!_audio_*.*") do (
        echo Find Audio: %%a
        set "aud_path=%%a"
        set "output=!vid_dir!!base_key!.mp4"
        echo.
        echo.
        ffmpeg.exe -i "!vid_path!" -i "!aud_path!" -c:v copy -c:a copy "!output!" -y
        echo.
        echo Output: !output!
    )

    echo.
    echo.
    echo.
)

endlocal
timeout /t 30
