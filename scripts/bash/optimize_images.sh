#!/bin/bash
# Recursively optimize all PNG and JPG files wherever they are from the script position and inner ( based on OPTING, PNGCRUSH, ADVANCECOMP and JPEGOPTIM )
find . -type f -iname "*.png" -exec optipng -nb -nc {} \;
find . -type f -iname "*.png" -exec advpng -z4 {} \;
find . -type f -iname "*.png" -exec pngcrush -rem gAMA -rem alla -rem cHRM -rem iCCP -rem sRGB -rem time -ow {} \;
find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) -exec jpegoptim -f --strip-all {} \;
