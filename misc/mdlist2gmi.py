#! /usr/bin/env python3

import re

def concat_gmi(link, name):
    return "=> " + link + "\t" + name


f = open("posts.md")
lines = f.readlines()

regxp = re.compile("- \[(.+)\]\((.+)\)<br>")

for l in lines:
    if l == "### Long Term Update\n":
        print("")
        print(l, end="")

    match = regxp.match(l)
    if match:
        link = match.group(2)
        if re.match(".+\.[a-z]+\.txt$", link):
            link = link[:-4]
        else:
            link = "org/" + link + ".org"

        print(concat_gmi(link, match.group(1)))


f.close()
