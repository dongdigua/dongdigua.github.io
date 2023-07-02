#! /bin/sh

printf "20 text/gemini\r\n"
printf "Domain: $SERVER_NAME\r\n"
printf "Server: $SERVER_SOFTWARE\r\n"
printf "OS: $(uname -or)\r\n"
printf "Up: $(uptime)\r\n"
printf "\n"
printf "$(free -h)\r\n"
