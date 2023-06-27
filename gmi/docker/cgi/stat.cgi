#! /usr/bin/sh

printf "20 text/gemini\r\n";
printf "OS: $(uname -rv)\r\nuptime: $(uptime)\r\nserver: $SERVER_SOFTWARE\r\nauth: $AUTH\r\n";
