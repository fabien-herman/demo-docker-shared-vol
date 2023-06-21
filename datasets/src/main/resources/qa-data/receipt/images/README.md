To convert images to the required format you can use a script like this:

```sh
#!/bin/bash
source=toshiba.png
#source=HM.svg
destination=$(basename "${source}" | sed 's/\(.*\)\..*/\1/')
size=100
convert -resize ${size}x "${source}" tmp.png
#convert -resize ${size}x -negate "${source}" tmp.png
#convert -resize ${size}x -monochrome "${source}" tmp.png
#convert -resize ${size}x -remap pattern:gray50 "${source}" tmp.png
pngcrush tmp.png "${destination}_${size}.png"
identify "${destination}_${size}.png"
base64 -w0 "${destination}_${size}.png" > "${destination}_${size}.base64"
rm tmp.png
```

This requires imagemagick and pngcrush (although this is not strictly necessary)
