#! /bin/sh

if [ -z $AUTH_TYPE ]; then
    printf "60 \r\n"
else
    printf "20 text/plain\r\n"
    printf "auth: $AUTH_TYPE\r\nhash: $TLS_CLIENT_HASH\r\n"
fi
