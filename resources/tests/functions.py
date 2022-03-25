import commentjson
import os
import re

funcs = []

dirname = os.path.join(".", "scripts")
for filename in os.listdir(dirname):
    if os.path.isfile(os.path.join(dirname, filename)):
        print(f"Reading {filename}")
        with open(os.path.join(dirname, filename), "r") as funcsFile:
            lines = funcsFile.read().split("\n")
            for line in lines:
                match = re.search(r"function ([^\(]*)", line.strip())
                if match:
                    funcs.append(match.group(1))
funcs = set(funcs)
funcs = list(funcs)
funcs.sort()

with open(os.path.join(".", "resources", "tests", "output", "funcs.json"), "w+") as funcsJSON:
    funcsJSON.write(commentjson.dumps(funcs, indent=2))
