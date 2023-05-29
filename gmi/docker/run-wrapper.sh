#! /bin/sh

crond -f -d 8 &
tail -f /var/log/git.log &
agate --content dongdigua.github.io/gmi -e --hostname $GEMINI_HOST

wait -n
echo $?
