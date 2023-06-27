#! /bin/sh

if test -f /etc/ssl/gmid.pem; then
    echo "OK certificate exists"
else
    echo "generating certificate..."
    apk add libressl
    libressl req -x509 -newkey rsa:4096 -nodes \
        -keyout /etc/ssl/private/gmid.key \
        -out /etc/ssl/gmid.pem \
        -days 365 -subj "/CN=$GEMINI_HOST"
fi
