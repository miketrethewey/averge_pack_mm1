import json
import os

images = []
for r,d,f in os.walk(
    os.path.join(
        ".",
        "images"
    )
):
    for filename in f:
        image = os.path.join(r, filename)
        image = image[2:]
        image = image.replace("\\", "/")
        images.append(image)

outputdir = os.path.join(".","resources","tests","output")
if not os.path.exists(outputdir):
    os.makedirs(outputdir)
with open(os.path.join(outputdir, "imageFiles.json"), mode="w+", encoding="utf-8") as imagesJSON:
    imagesJSON.write(json.dumps(sorted(images), indent=2))
