# pylint: disable=invalid-name
'''
Validate Locations: function names, location references, item names
'''
import os
import re
import commentjson

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
    images = commentjson.load(imagesFile)

def checkImageRefs(loc):
    for chest_img in [
        "chest_unavailable_img",
        "chest_unopened_img",
        "chest_opened_img"
    ]:
        if chest_img in loc:
            linImg = loc[chest_img].replace("\\","/")
            winImg = loc[chest_img].replace("/","\\")
            if linImg not in images and winImg not in images:
                print(f" 🔴Invalid '{chest_img}' reference for '{loc['name']}'")

def digForChildren(loc):
    children = []
    if "children" in loc:
        children = loc["children"]
    elif "sections" in loc:
        children = loc["sections"]
    for child in children:
        locs.append(child["name"])
        digForChildren(child)
        checkImageRefs(child)
        if "access_rules" in child:
            for access_rule in child["access_rules"]:
                access_items = list(
                    map(
                        lambda x: x.strip(),
                        access_rule.split(",")
                    )
                )
                for access_item in access_items:
                    err = False
                    errMsg = ""
                    match = re.search(
                        r"([\[\{\$\@]?)" +
                        r"([\$\@]?)" +
                        r"([\w\s\/\-\'\(\)]+)" +
                        r"(?:[\]\}\|\:]*)" +
                        r"([\d]*)" +
                        r"([\]\}]*)",
                        access_item
                    )
                    circle = ""
                    if match:
                        if match.group(3) != "":
                            check = match.group(3)
                            for char in ["{","}","[","]"]:
                                check = check.replace(char,"")
                            if match.group(1) == "$" or \
                                match.group(2) == "$":
                                err = check not in funcs
                                circle = "🔴"
                                errMsg = "not a valid function"
                            elif match.group(1) == "@" or \
                                match.group(2) == "@":
                                err = check[:check.find("/"):] not in locs
                                if err:
                                    print(match.groups())
                                circle = "🔴"
                                errMsg = "not a valid location"
                            elif check not in items:
                                err = True
                                circle = "🔴"
                                errMsg = "not a valid item code"
                            elif check in itemToFunc and itemToFunc[check][0] != "pazuzuSeven":
                                err = True
                                circle = "🟡"
                                errMsg = f"can be replaced with '{itemToFunc[check]}'"

                    if err:
                        print(f"> {loc['name']}")
                        print(f">  {child['name']}")
                        print(f">   {circle}'{access_item}' {errMsg}")

itemToFunc = {}
items = []
funcs = []
locs = []

with open(
    os.path.join(
        ".",
        "resources",
        "tests",
        "output",
        "itemToFunc.json"
    ),
    "r",
    encoding="utf-8"
) as itemToFuncFile:
    itemToFunc = commentjson.load(itemToFuncFile)
with open(
    os.path.join(
        ".",
        "resources",
        "tests",
        "output",
        "itemCodes.json"
    ),
    "r",
    encoding="utf-8"
) as itemsFile:
    items = commentjson.load(itemsFile)
with open(
    os.path.join(
        ".",
        "resources",
        "tests",
        "output",
        "funcNames.json"
    ),
    "r",
    encoding="utf-8"
) as funcsFile:
    funcs = commentjson.load(funcsFile)

print("Reading Locations")
dirname = os.path.join(".", "locations")
for r, d, f in os.walk(dirname):
    if "main.json" in f:
        f.pop(f.index("main.json"))
        f.reverse()
        f.append("main.json")
        f.reverse()
    for filename in f:
        if os.path.isfile(os.path.join(r, filename)):
            if os.path.splitext(filename)[1].lower() == ".json":
                print(f"Reading: {os.path.join(r, filename)}")
                with open(os.path.join(r, filename), "r", encoding="utf-8") as locsFile:
                    locsManifest = commentjson.load(locsFile)
                    for loc in locsManifest:
                        checkImageRefs(loc)
                        if "access_rules" in loc:
                            locs.append(loc["name"])
                        digForChildren(loc)

print("")

outputdir = os.path.join(".","resources","tests","output")
if not os.path.exists(outputdir):
    os.makedirs(outputdir)
with open(os.path.join(outputdir, "locNames.json"), mode="w+", encoding="utf-8") as locsJSON:
    locsJSON.write(commentjson.dumps(sorted(locs), indent=2))
