#! /bin/sh

ls gmi | xargs -I {} ln -s gmi/{} {}.txt
ln -s lol.diff lol.diff.txt
