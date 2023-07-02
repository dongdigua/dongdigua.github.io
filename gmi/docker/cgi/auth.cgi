#! /usr/bin/python

# nobody write perl right?

from os import environ
import sys
import subprocess
import re


if "GEMINI_SEARCH_STRING" not in environ:
    print("11 signed message",end="\r\n")
    sys.exit()

query = environ["GEMINI_SEARCH_STRING"]
host = environ["SERVER_NAME"]

p = subprocess.Popen(["gpgv", "--keyring", "./keyring"], stdin=subprocess.PIPE)
p.communicate(input=query.encode())

if p.returncode != 0:
    print("gpg failed")
    sys.exit()

pattern = "^{}:([0-9a-z]+)$".format(host)
line = query.splitlines()[3]
match = re.match(pattern, line)

if match == None:
    print("bad hash")
    sys.exit()

print("20 text/gemini",end="\r\n")
print(match.group(1),end="\r\n")
