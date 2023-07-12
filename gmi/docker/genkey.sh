#! /bin/sh

if test -f /ssl/gmid.pem; then
    echo "OK certificate exists"
else
    echo "generating certificate..."
    mkdir /ssl
    apk add --no-cache libressl
    libressl req -x509 -newkey rsa:4096 -nodes \
        -keyout /ssl/private/gmid.key \
        -out /ssl/gmid.pem \
        -days 365 -subj "/CN=$GEMINI_HOST"
fi
