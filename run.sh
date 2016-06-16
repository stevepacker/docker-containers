#!/bin/sh


if [ -f /app/package.json ]; then
    cd /app
    if [ ! -d /app/node_modules ] || [ ! "$(ls -A /app/node_modules)" ]; then
        exec npm install
    fi
    exec npm run-script start
fi
