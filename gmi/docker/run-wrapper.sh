#! /bin/sh

sh genkey.sh

crond -f -d 8 &
tail -f /var/log/git.log &
gmid -f -c /dongdigua.github.io/gmi/docker/gmid.conf -Dgem_host=$GEMINI_HOST

wait -n
echo $?
