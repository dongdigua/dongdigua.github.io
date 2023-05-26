#! /bin/sh

crond -f &
agate --content dongdigua.github.io/gmi --hostname $GEMINI_HOST 

wait -n
echo $?
