#! /bin/sh

REPO=/dongdigua.github.io

$REPO/gmi/docker/genkey.sh

crond -f -d 8 &
tail -f /var/log/git.log &
gmid -f -c $REPO/gmi/docker/gmid.conf -Dgem_host=$GEMINI_HOST

wait -n
echo $?
