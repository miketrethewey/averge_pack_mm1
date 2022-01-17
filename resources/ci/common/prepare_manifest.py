import common
import json
import os                 # for env vars
from shutil import copy   # file manipulation

def prepare_manifest():
  env = common.prepare_env()

  APPVERSION = ""

  # set tag to app_version.txt
  with open(os.path.join("..", "build", "app_version.txt"), "r") as f:
      APPVERSION = f.readlines()[0]

  if APPVERSION != "":
      with open(os.path.join("manifest.json"), "r+") as manifestFile:
          manifestJSON = json.load(manifestFile)
          manifestJSON["package_version"] = APPVERSION
          manifestFile.seek(0)
          manifestFile.write(json.dumps(manifestJSON, indent=2))
          manifestFile.truncate()

def main():
  prepare_manifest()

if __name__ == "__main__":
  main()
else:
  raise AssertionError("Script improperly used as import!")
