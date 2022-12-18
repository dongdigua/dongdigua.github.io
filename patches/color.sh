#! /bin/sh

# don't forget & is also a metachar
sed -i \
's/<a href="https:\/\/www.youtube.com\/@Computerphile">\&lt;C\&gt;<\/a>/<a style="color:#0ee033" href=https:\/\/www.youtube.com\/@Computerphile>\&lt;C\&gt;<\/a>/g' \
internet_collections.html

