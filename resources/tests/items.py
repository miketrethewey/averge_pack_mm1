import commentjson
import os

codes = []

dirname = os.path.join(".", "items")
for filename in os.listdir(dirname):
    if os.path.isfile(os.path.join(dirname, filename)):
        print(f"Reading: {filename}")
        with open(os.path.join(dirname, filename), "r") as itemsFile:
            itemsManifest = commentjson.load(itemsFile)
            for item in itemsManifest:
                if "codes" in item:
                    item = item["codes"].split(",")
                    codes += item
                if "stages" in item:
                    for stage in item["stages"]:
                        if "codes" in stage:
                            stage = stage["codes"].split(",")
                            codes += stage

codes = set(codes)
codes = list(codes)
codes.sort()

outputdir = os.path.join(".","resources","tests","output")
if not os.path.exists(outputdir):
    os.makedirs(outputdir)
with open(os.path.join(outputdir, "itemCodes.json"), "w+") as itemsJSON:
    itemsJSON.write(commentjson.dumps(codes, indent=2))
