import commentjson
import os

itemToFunc = {}
items = []
funcs = []
locs = []

with open(os.path.join(".", "resources", "tests", "output", "itemToFunc.json"), "r") as itemToFuncFile:
    itemToFunc = commentjson.load(itemToFuncFile)
with open(os.path.join(".", "resources", "tests", "output", "itemCodes.json"), "r") as itemsFile:
    items = commentjson.load(itemsFile)
with open(os.path.join(".", "resources", "tests", "output", "funcNames.json"), "r") as funcsFile:
    funcs = commentjson.load(funcsFile)

print("Reading Locations")
dirname = os.path.join(".", "locations")
for r, d, f in os.walk(dirname):
    for filename in f:
        if os.path.isfile(os.path.join(r, filename)):
            if os.path.splitext(filename)[1].lower() == ".json":
                print(f"Reading: {dirname}{os.sep}{filename}")
                with open(os.path.join(r, filename), "r") as locsFile:
                    locsManifest = commentjson.load(locsFile)
                    for loc in locsManifest:
                        if "access_rules" in loc:
                            locs.append(loc["name"])
                        if "children" in loc:
                            for child in loc["children"]:
                                locs.append(child["name"])
                                if "access_rules" in child:
                                    for access_rule in child["access_rules"]:
                                        access_items = list(map(lambda x: x.strip(), access_rule.split(",")))
                                        for access_item in access_items:
                                            if '[' not in access_item and \
                                                ']' not in access_item and \
                                                '{' not in access_item and \
                                                '}' not in access_item:

                                                err = False

                                                if "$" in access_item:
                                                    err = access_item[1::] not in funcs
                                                    errMsg = "not a valid function"
                                                elif "@" in access_item:
                                                    err = access_item[1:access_item.find("/"):] not in locs
                                                    errMsg = "not a valid location"
                                                elif access_item not in items:
                                                    err = True
                                                    errMsg = "not a valid item code"
                                                elif access_item in itemToFunc:
                                                    err = True
                                                    errMsg = f"can be replaced with '{itemToFunc[access_item]}'"

                                                if err:
                                                    print(f"> {loc['name']}")
                                                    print(f">  {child['name']}")
                                                    print(f">   '{access_item}' {errMsg}")
print("")
