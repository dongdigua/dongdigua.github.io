#! /bin/sh

ls gmi | xargs -I {} ln -s gmi/{} gmi/{}.txt
ln -s code/lol.diff lol.diff.txt
ln -s pgp pgp.txt
