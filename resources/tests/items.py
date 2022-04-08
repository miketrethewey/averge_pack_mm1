import commentjson
import os

codes = []

print("Reading Items")
dirname = os.path.join(".", "items")
for filename in os.listdir(dirname):
    if os.path.isfile(os.path.join(dirname, filename)):
        if os.path.splitext(filename)[1].lower() == ".json":
            print(f"Reading: {dirname}{os.sep}{filename}")
            with open(os.path.join(dirname, filename), "r") as itemsFile:
                itemsManifest = commentjson.load(itemsFile)
                for item in itemsManifest:
                    if "codes" in item:
                        item = list(map(lambda x: x.strip(), item["codes"].split(",")))
                        codes += item
                    if "stages" in item:
                        for stage in item["stages"]:
                            if "codes" in stage:
                                stage = list(map(lambda x: x.strip(), stage["codes"].split(",")))
                                codes += stage
print("")

codes = set(codes)
codes = list(codes)
codes.sort()

outputdir = os.path.join(".","resources","tests","output")
if not os.path.exists(outputdir):
    os.makedirs(outputdir)
with open(os.path.join(outputdir, "itemCodes.json"), mode="w+", encoding="utf-8") as itemsJSON:
    itemsJSON.write(commentjson.dumps(codes, indent=2))
