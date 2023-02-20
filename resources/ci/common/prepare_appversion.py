# pylint: disable=invalid-name
'''
Prepare AppVersion
'''
import os                 # for env vars
from shutil import copy   # file manipulation
import common
import commentjson


def prepare_appversion():
    '''
    Prepare AppVersion
    '''
    env = common.prepare_env()

    CI_SETTINGS = {}
    manifest_path = os.path.join(
        ".",
        "resources",
        "app",
        "meta",
        "manifests",
        "ci.json"
    )
    if not os.path.isfile(manifest_path):
        raise AssertionError("Manifest not found: " + manifest_path)
    with open(manifest_path, "r", encoding="utf-8") as ci_settings_file:
        CI_SETTINGS = commentjson.load(ci_settings_file)
    with open(os.path.join(".", "manifest.json"), "r", encoding="utf-8") as packManifestFile:
        packManifestJSON = commentjson.load(packManifestFile)

        dirs = [
            os.path.join("..", "build"),
            os.path.join("..", "merge"),
            os.path.join("..", "merge", "scripts")
        ]
        for dirname in dirs:
            if not os.path.isdir(dirname):
                os.makedirs(dirname)

        # set tag to app_version.txt
        if not env["GITHUB_TAG"] == "":
            with open(
                os.path.join(
                    ".",
                    *CI_SETTINGS["common"]["prepare_appversion"]["app_version"]
                ),
                "w+",
                encoding="utf-8"
            ) as f:
                _ = f.read()
                f.seek(0)
                f.write(env["GITHUB_TAG"])
                f.truncate()
                print(f"Wrote {env['GITHUB_TAG']} as AppVersion")
            with open(
                os.path.join(
                    dirs[1],
                    "scripts",
                    "ver.lua"
                ),
                "w+",
                encoding="utf-8"
            ) as ver:
                _ = ver.read()
                ver.seek(0)
                toWrite = [
                    f"print(\"Package Name:    {packManifestJSON['name']}\")",
                    f"print(\"Package Author:  {packManifestJSON['author']}\")",
                    f"print(\"Package Version: {env['GITHUB_TAG']}\")"
                ]
                print(toWrite)
                ver.writelines(toWrite)
                ver.truncate()

        copy(
            os.path.join(
                ".",
                *CI_SETTINGS["common"]["prepare_appversion"]["app_version"]
            ),
            os.path.join(
                dirs[0],
                "app_version.txt"
            )
        )


def main():
    '''
    Main
    '''
    prepare_appversion()


if __name__ == "__main__":
    main()
else:
    raise AssertionError("Script improperly used as import!")
