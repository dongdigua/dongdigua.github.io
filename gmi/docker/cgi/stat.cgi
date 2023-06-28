#! /bin/sh

printf "20 text/gemini\r\n"
printf "server: $SERVER_SOFTWARE\r\nOS: $(uname -or)\r\nuptime: $(uptime)\r\n"
