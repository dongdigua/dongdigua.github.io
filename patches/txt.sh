#! /bin/sh

set -x

cd gmi
ls *.gmi | xargs -I {} ln -s {} {}.txt
cd ..
ln -s pgp pgp.txt
