## First of all
- Download the latest portable [ImageMagick](https://imagemagick.org/script/download.php#windows) binaries
    - C:\cli\magick_utilities.cmd
    - C:\cli\bin\magick.exe
- Drag and drop folder of images, or image file over `magick_utilities.cmd`
    - See [Usage](#Usage)

## Usage
- Crop with Area
    - Read [ImageMagick Geometry](https://imagemagick.org/script/command-line-processing.php#geometry)
    - Sample: 400x200+20+80
        - Width: 400px
        - Height: 200px
        - Top: 20px
        - Left: 80px
    - Starts from top 20px, select a 400px wide area that ends at 420px
    - Starts from left 80px, select a 200px high area that ends at 280px
    - Crop the image inside the area
- Cut off border
    - Read [ImageMagick Geometry](https://imagemagick.org/script/command-line-processing.php#geometry)
    - Sample: 400x200
        - Width: 400px
        - Height: 200px
    - Cut both 400px from left and right of the image
    - Cut both 200px from top and bottom of the image
- Convert images
    - Image Quality: 1-100
    - Default: 90
    - For `png`, it is compress ratio, which is 1/10 of quality value
