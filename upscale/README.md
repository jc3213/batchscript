# First of all

- Download and unpack latest [realesrgan-ncnn-vulkan](https://github.com/xinntao/Real-ESRGAN/releases)
    - C:\cli\upscale_ncnn_utilities.cmd
    - C:\cli\bin\realesrgan-ncnn-vulkan.exe
    - C:\cli\bin\models\\*
- Download and unpack latest [waifu2x-ncnn-vulkan](https://github.com/nihui/waifu2x-ncnn-vulkan/releases)
    - C:\cli\upscale_ncnn_utilities.cmd
    - C:\cli\bin\waifu2x-ncnn-vulkan.exe
    - C:\cli\bin\models-cunet\\*
    - C:\cli\bin\models-upconv_7_anime_style_art_rgb\\*
    - C:\cli\bin\models-upconv_7_photo\\*
- Drag and drop image files or folder over `upscale_ncnn_utilities.cmd`
- Execute `upscale_ncnn_utilities.ps1` with `Run with PowerShell`
- Read [Real-ESRGAN Settings](#Real-ESRGAN-Settings)
- Read [Waifu2x Settings](#Waifu2x-Settings)

## Real-ESRGAN Settings
- Model (model)
    - realesrgan-x4plus
    - realesrgan-x4plus-anime
    - realesr-animevideov3
- Multiplier (scale)
    - 2x
        - *only for realesr-animevideov3*
    - 3x
        - *only for realesr-animevideov3*
    - 4x
- Output Format (format)
    - jpg
    - png
    - webp
- Output Result
    - `${name} (Real-ESRGAN)(${model})(${scale}).${format}`

## Waifu2x Settings
- Model (model)
    - models-cunet
    - models-upconv_7_anime_style_art_rgb
    - models-upconv_7_photo
- Multiplier (scale)
    - 2x
    - 4x
    - 8x
- Denoise Level (noise)
    - 0
        - *Disable*
    - 1
    - 2
    - 3
- TTA Mode (tta)
    - 1
        - *Enable*
- Output Format (format)
    - jpg
    - png
    - webp
- Output Result
    - `${name} (Waifu2x)(${model})(${scale})(${noise})(${tta})?.(${format})`
