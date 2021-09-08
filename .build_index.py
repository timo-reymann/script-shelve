#!/usr/bin/env python3

import glob
import os.path as path

IGNORED=[
    "doc_generate",
    "LICENSE",
    "README.md"
]

lines = []

lines.append("Index")
lines.append("===")

for file in sorted(glob.iglob("**/**", recursive=True)):
    ignored = False
    for i in IGNORED:
        if file.startswith(i):
            ignored = True
            break
    if ignored:
        continue

    if file.endswith("/"):
        file = file[:-1]

    if len(file) == 0:
        continue

    if path.isdir(file):
        lines.append(f"## {file}")
    else:
        lines.append(f" - [{file}]({file})")

with open("Index.md", "w") as w:
    for line in lines:
        w.write(line + "\n")

