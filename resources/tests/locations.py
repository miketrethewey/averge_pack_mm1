import commentjson
import os

items = []
funcs = []
locs = []

with open(os.path.join(".", "resources", "tests", "output", "items.json"), "r") as itemsFile:
    items = commentjson.load(itemsFile)
with open(os.path.join(".", "resources", "tests", "output", "funcs.json"), "r") as funcsFile:
    funcs = commentjson.load(funcsFile)

dirname = os.path.join(".", "locations")
for filename in os.listdir(dirname):
    if os.path.isfile(os.path.join(dirname, filename)):
        print(f"Reading {filename}")
        with open(os.path.join(dirname, filename), "r") as locsFile:
            locsManifest = commentjson.load(locsFile)
            for loc in locsManifest:
                if "access_rules" in loc:
                    locs.append(loc["name"])
                    if "children" in loc:
                        for child in loc["children"]:
                            locs.append(child["name"])
                            if "access_rules" in child:
                                for access_rule in child["access_rules"]:
                                    access_items = access_rule.split(",")
                                    for access_item in access_items:
                                        if '[' not in access_item and \
                                            ']' not in access_item and \
                                            '{' not in access_item and \
                                            '}' not in access_item:

                                            err = False

                                            if "$" in access_item:
                                                err = access_item[1::] not in funcs
                                            elif "@" in access_item:
                                                err = access_item[1:access_item.find("/"):] not in locs
                                            else:
                                                err = access_item not in items

                                            if err:
                                                print(f"> {loc['name']}")
                                                print(f">  {child['name']}")
                                                print(f">   {access_item}")
