#! /bin/sh

crond -f -d 8 &
tail -f /var/log/git.log &
agate -eC --content dongdigua.github.io --hostname $GEMINI_HOST

wait -n
echo $?
