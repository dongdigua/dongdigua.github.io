#! /bin/sh

cd /dongdigua.github.io
git pull --rebase >> /var/log/git.log 2>&1
python misc/mdlist2gmi.py > posts.gmi
cp -r gmi/docker/cgi .
rm index.gmi
git checkout -- index.gmi
pkill -HUP gmid
