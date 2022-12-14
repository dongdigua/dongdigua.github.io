#! /bin/sh

ls gmi | xargs -I {} ln -s gmi/{} {}.txt
