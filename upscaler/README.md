# First of all
- Download and unpack latest [realesrgan-ncnn-vulkan](https://github.com/xinntao/Real-ESRGAN/releases), [realcugan-ncnn-vulkan](https://github.com/nihui/realcugan-ncnn-vulkan/releases) and [waifu2x-ncnn-vulkan](https://github.com/nihui/waifu2x-ncnn-vulkan/releases)
    - C:\cli\\[upscaler_ncnn_utilities.cmd](https://raw.githubusercontent.com/jc3213/batchscript/main/upscaler/upscaler_ncnn_utilities.cmd)
    - C:\cli\upscaler\realesrgan-ncnn-vulkan.exe
    - C:\cli\upscaler\models\\\*
    - C:\cli\upscaler\realcugan-ncnn-vulkan.exe
    - C:\cli\upscaler\models-se\\*
    - C:\cli\upscaler\models-pro\\*
    - C:\cli\upscaler\waifu2x-ncnn-vulkan.exe
    - C:\cli\upscaler\models-cunet\\*
    - C:\cli\upscaler\models-upconv_7_anime_style_art_rgb\\*
- Drag and drop image files or directories over `upscaler_ncnn_utilities.cmd`
- Execute `upscale_ncnn_utilities.ps1` with `Run with PowerShell`
- Read upscaler [settings](#Settings)

## Image Fixer
- Download the latest [ImageMagick](https://imagemagick.org/script/download.php#windows) and [realcugan-ncnn-vulkan](https://github.com/nihui/realcugan-ncnn-vulkan/releases) binaries
    - C:\cli\\[manga_fixer.cmd](https://raw.githubusercontent.com/jc3213/batchscript/main/upscaler/image_fixer.cmd)
    - C:\cli\upscaler\realcugan-ncnn-vulkan.exe
    - C:\cli\upscaler\models-se\\*
- Drag and drop folders of images, or image files over `manga_fixer.cmd`
- It will not work porperly for certain image files


## Image Fixer Extreme
- Download the latest [ImageMagick](https://imagemagick.org/script/download.php#windows), [realcugan-ncnn-vulkan](https://github.com/nihui/realcugan-ncnn-vulkan/releases), [realesrgan-ncnn-vulkan](https://github.com/xinntao/Real-ESRGAN/releases), and [realcugan-ncnn-vulkan](https://github.com/nihui/realcugan-ncnn-vulkan/releases) binaries
    - C:\cli\\[manga_fixer_extreme.cmd](https://raw.githubusercontent.com/jc3213/batchscript/main/upscaler/image_fixer_extreme.cmd)
    - C:\cli\upscaler\realcugan-ncnn-vulkan.exe
    - C:\cli\upscaler\models-se\\*
    - C:\cli\upscaler\realesrgan-ncnn-vulkan.exe
    - C:\cli\upscaler\models\realesr-animevideov3-x2.*
    - C:\cli\upscaler\waifu2x-ncnn-vulkan.exe
    - C:\cli\upscaler\models-cunet\\*
- Drag and drop folders of images, or image files over `manga_fixer_extreme.cmd`
- It will cost more power, time, and disk space for better quality and compatibility

## Settings
- Upscaler
    - Real-ESRGAN Plus Anime
        - Engine `ncnn`: Real-ESRGAN
        - Model `model`: realesrgan-x4plus-anime
    - Real-ESRGAN Anime Video v3
        - Engine `ncnn`: Real-ESRGAN
        - Model `model`: realesr-animevideov3
    - Real-CUGAN Se
        - Engine `ncnn`: Real-CUGAN
        - Model `model`: models-se
    - Real-CUGAN Pro
        - Engine `ncnn`: Real-CUGAN
        - Model `model`: models-pro
    - Waifu2x CUnet
        - Engine `ncnn`: Waifu2x
        - Model `model`: models-cunet
    - Waifu2x Anime Style
        - Engine `ncnn`: Waifu2x
        - Model `model`: models-upconv_7_anime_style_art_rgb
- Scale Ratio `scale`
    - *not available for `realesrgan-x4plus-anime` and `models-pro`*
    - 2x, 4x
    - Default: 2x
- Denoise Level `noise`
    - *not available for `Real-ESRGAN`*
    - *only `Real-CUGAN` has -1 for denoise*
    - -1, 0, 1, 2, 3
    - Default: 0
    - Recommended: 1
- Split Tiles `tile`
$$\\frac{{VRAM \times 1024^3}}{{height \times width \times float.p}} \\approx result$$
    - `6GB` VRAM, `1600`x`1600`, FP`16`, tile≈156
    - Default: 0
        - Auto
- TTA Mode `tta`
    - 1
        - *Enable*
    - Default: Disabled
- Output Format `format`
    - jpg, png, webp
    - Default: png
- Output Result
    - `${name} (${ncnn})(${model})(${scale})(${noise})?(${tta})?.${format}`
