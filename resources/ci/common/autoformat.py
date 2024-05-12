# Tool to auto-format all the region files in a standard way.
#
# To use, run "python -m tests.asserts.autoformat" from a working directory of "sm-json-data".

import pyjson5 as json
import tempfile
from pathlib import Path

import resources.ci.common.format_json as format_json

def autoformat(test=False):
    made_changes = False
    for path in sorted(Path("./").glob("**/*.json")):
        with path.open("r", encoding="latin_1") as room_file:
            # if "artifacts" in str(path) or "markers" in str(path):
            #     continue
            # print("🟢Reading", path)
            room_json = json.load(room_file)
            if "schema" in str(path):
                continue
            # if room_json.get("$schema") != "../../../schema/m3-room.schema.json":
            #     continue

            new_room_json = format_json.format(room_json, indent=2)
            new_room_json += "\n"
            new_room_json = new_room_json.encode("latin_1").decode("raw_unicode_escape").encode("utf-16", "surrogatepass").decode("utf-16")

            # Validate that the new JSON is equivalent to the old (i.e. the differences affect formatting only):
            assert json.loads(new_room_json) == room_json

            # Compare binary of the file to a temp with the newly-formatted data
            _, temp_file = tempfile.mkstemp(suffix=".json")
            with open(temp_file, "r+", encoding="latin_1") as temp_handle:
                room_file.seek(0)
                temp_handle.write(new_room_json)
                temp_handle.seek(0)
                room_data = room_file.read()
                temp_data = temp_handle.read()
                identical = room_data == temp_data
                if not identical:
                    made_changes = True
                    print("🟡Processing", path)
                    # Write the auto-formatted output:
                    path.write_text(new_room_json, encoding="latin_1", newline="\r\n")
    if test and made_changes:
        print("🔴ERROR: Had to make edits, bailing!")
        exit(1)

if __name__ == "__main__":
    autoformat()
