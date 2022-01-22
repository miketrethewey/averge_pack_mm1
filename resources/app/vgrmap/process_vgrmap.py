import json
import os

INPUTFILEPATH = os.path.join(".","resources","app","vgrmap","input","20220122.json")
OUTPUTFILEPATH = INPUTFILEPATH.replace("input","output")

locationJSON = []
with open(INPUTFILEPATH,"r") as inputfile:
  locationJSON = json.load(inputfile)

newLocationsJSON = []

for loc in locationJSON:
  newLoc = loc.copy()
  for k,v in loc.items():
    if "RequiredPowers" in k and "String" not in k:
      del newLoc[k]
  del newLoc["Name"]
  del newLoc["LocationId"]
  newLocationsJSON.append(newLoc)

with open(OUTPUTFILEPATH, "w") as outputfile:
  outputfile.write(json.dumps(newLocationsJSON,indent=2))
