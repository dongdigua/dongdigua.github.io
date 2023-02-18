#! /bin/sh

ls gmi  | xargs -I {} ln -s gmi/{} {}.txt
ln -s code/lol.diff lol.diff.txt
