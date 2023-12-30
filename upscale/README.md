# First of all

- Download and install latest [realesrgan-ncnn-vulkan](https://github.com/xinntao/Real-ESRGAN/releases)
    - C:\cli\realesrgan-ncnn-vulkan.cmd
    - C:\cli\bin\realesrgan-ncnn-vulkan.exe
    - C:\cli\bin\models\\*
- Download and install latest [waifu2x-ncnn-vulkan](https://github.com/nihui/waifu2x-ncnn-vulkan/releases)
    - C:\cli\waifu2x-ncnn-vulkan.cmd
    - C:\cli\bin\waifu2x-ncnn-vulkan.exe
    - C:\cli\bin\models-cunet\\*
    - C:\cli\bin\models-upconv_7_anime_style_art_rgb\\*
    - C:\cli\bin\models-upconv_7_photo\\*
- Drag and drop image files or folder over `waifu2x_utilities.cmd` or `realesrgan_utilities.cmd`
    - Read [Real-ESRGAN Settings](#Real-ESRGAN-Settings)
    - Read [Waifu2x Settings](#Waifu2x-Settings)

## Real-ESRGAN Settings
- Model
    - realesrgan-x4plus
    - realesrgan-x4plus-anime
    - realesrgan-animevideov3
- Multiplier
    - 2x
        - *only for realesr-animevideov3*
    - 3x
        - *only for realesr-animevideov3*
    - 4x
- Output Format
    - jpg
    - png
    - webp

## Waifu2x Settings
- Model
    - models-cunet
    - models-upconv_7_anime_style_art_rgb
    - models-upconv_7_photo
- Multiplier
    - 2x
    - 4x
    - 8x
- Denoise Level
    - 0
        - *Disable*
    - 1
    - 2
    - 3
- TTA Mode
    - 1
        - *Enable*
- Output Format
    - jpg
    - png
    - webp
