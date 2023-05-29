#! /bin/sh

cd /dongdigua.github.io
git pull --rebase >> /var/log/git.log 2>&1
