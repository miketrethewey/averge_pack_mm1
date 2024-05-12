# pylint: disable=invalid-name
"""Gathers item codes for location testing"""

import json
import os
import commentjson

chathud = {}
codes = []
images = []

with open(
    os.path.join(
        ".",
        "resources",
        "tests",
        "output",
        "imageFiles.json"
    ),
    "r",
    encoding="utf-8"
) as imagesFile:
    images = json.load(imagesFile)

print("Reading Items")
dirname = os.path.join(".", "items")
for filename in os.listdir(dirname):
    if os.path.isfile(os.path.join(dirname, filename)):
        if os.path.splitext(filename)[1].lower() == ".json":
            print(f"Reading: {os.path.join(dirname, filename)}")
            with open(os.path.join(dirname, filename), "r", encoding="utf-8") as itemsFile:
                itemsManifest = commentjson.load(itemsFile)
                for item in itemsManifest:
                    if "img" in item:
                        linImg = item["img"].replace("\\","/")
                        winImg = item["img"].replace("/","\\")
                        if linImg not in images and winImg not in images:
                            print(f" 🔴Invalid image reference for '{item['name']}'")
                    if "codes" in item:
                        primary = item["codes"].split(",")[0]
                        chathud[primary] = {
                            "codes": [],
                            "secondary_codes": [],
                            "name": item["name"],
                            "type": item["type"]
                        }
                        itemCodes = list(map(lambda x: x.strip(), item["codes"].split(",")))
                        for tmp in sorted(itemCodes):
                            chathud[primary]["codes"].append(tmp)
                        codes += itemCodes
                    else:
                        print(f"🔴Codes not defined for '{item['name']}'")
                        continue
                    if "stages" in item:
                        for stage in item["stages"]:
                            if "img" in stage:
                                linImg = stage["img"].replace("\\","/")
                                winImg = stage["img"].replace("/","\\")
                                if linImg not in images and winImg not in images:
                                    print(f" 🔴Invalid image reference for '{item['name']}:{stage['name']}'")
                            for code in ["codes", "secondary_codes"]:
                                if code in stage:
                                    stageCodes = list(
                                        map(
                                            lambda x: x.strip(),
                                            stage[code].split(",")
                                        )
                                    )
                                    for tmp in sorted(stageCodes):
                                        chathud[primary][code].append(tmp)
                                    chathud[primary][code] = sorted(set(chathud[primary][code]))
                                    codes += stageCodes
print("")

chatcodes = ""
for [thisCode, thisCodes] in chathud.items():
    name = thisCodes["name"]
    chatcodes += (f"{name}") + "\n"
    chatcodes += ("-" * len(name)) + "\n"
    chatcodes += (f"!hud {thisCode}") + "\n"
    if len(thisCodes["secondary_codes"]) or thisCodes["type"] == "consumable":
        chatcodes += (f"> !hud {thisCode} up") + "\n"
        chatcodes += (f"> !hud {thisCode} down") + "\n"
        for secondary in thisCodes["secondary_codes"]:
            chatcodes += (f"> !hud {thisCode} {secondary}") + "\n"

    chatcodes += ("") + "\n"

codes = set(codes)
codes = list(codes)
codes.sort()

outputdir = os.path.join(".","resources","tests","output")
if not os.path.exists(outputdir):
    os.makedirs(outputdir)
with open(os.path.join(outputdir, "chathud.txt"), mode="w+", encoding="utf-8") as chathudTxt:
    chathudTxt.write(chatcodes)
with open(os.path.join(outputdir, "itemCodes.json"), mode="w+", encoding="utf-8") as itemsJSON:
    itemsJSON.write(commentjson.dumps(sorted(codes), indent=2))
