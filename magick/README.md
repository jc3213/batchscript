## First of all
- Download the latest portable [ImageMagick](https://imagemagick.org/script/download.php#windows) binaries
    - C:\cli\magick_utilities.cmd
    - C:\cli\bin\magick.exe
- Drag and drop folders of images, or image files over `magick_utilities.cmd`
    - See [Usage](#Usage)

## Usage
- Crop with area
    - Read [ImageMagick Geometry](https://imagemagick.org/script/command-line-processing.php#geometry)
    - Sample: 400x200+20+80
        - Width: 400px
        - Height: 200px
        - Left: 20px
        - Top: 80px
    - Starts from left 20px, select a 400px wide area that ends at 420px
    - Starts from top 80px, select a 200px high area that ends at 280px
    - Crop the image inside the area
- Cut off border
    - Read [ImageMagick Geometry](https://imagemagick.org/script/command-line-processing.php#geometry)
    - Sample: 400x200
        - Width: 400px
        - Height: 200px
    - Cut 400px from both left and right of the image
    - Cut 200px from both top and bottom of the image
- Convert images
    - Image Quality: 1-100
    - Default: 90
    - For `png`, it is compress ratio, which is 1/10 of quality value
