# pylint: disable=invalid-name
'''
Prepare pack manifest
'''
import os                 # for env vars
import commentjson


def prepare_manifest():
    '''
    Prepare pack manifest
    '''
    # env = common.prepare_env()

    APPVERSION = ""

    # set tag to app_version.txt
    if os.path.exists(os.path.join("..", "build", "app_version.txt")):
        with open(os.path.join("..", "build", "app_version.txt"), "r", encoding="utf-8") as f:
            APPVERSION = f.readlines()[0].strip()

    with open(os.path.join("manifest.json"), mode="r+", encoding="utf-8") as manifestFile:
        manifestJSON = commentjson.load(manifestFile)
        if "variants" in manifestJSON:
            flags = []
            for [_, variant] in manifestJSON["variants"].items():
                if "flags" in variant:
                    for flag in variant["flags"]:
                        flags.append(flag)
            flags = set(flags)
            manifestJSON["flags"] = sorted(list(flags))

        if APPVERSION != "":
            manifestJSON["package_version"] = APPVERSION

        manifestFile.seek(0)
        manifestFile.truncate()
        manifestFile.write(commentjson.dumps(manifestJSON, indent=2))
        print(commentjson.dumps(manifestJSON, indent=2))


def main():
    '''
    Main
    '''
    prepare_manifest()


if __name__ == "__main__":
    main()
else:
    raise AssertionError("Script improperly used as import!")
