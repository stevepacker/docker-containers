#!/usr/bin/with-contenv sh

if [ -f /app/package.json ] && ([ ! -d /app/node_modules ] || [ ! "$(ls -A /app/node_modules)" ]); then
    cd /app
    if [ -n "$USER" ]; then
        exec s6-setuidgid "$USER" npm install
    else
        exec npm install
    fi
fi