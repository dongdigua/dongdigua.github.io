#! /bin/sh

crond -f -d 8 &
tail -f /var/log/git.log &
agate -C --content dongdigua.github.io --hostname $GEMINI_HOST

wait -n
echo $?
