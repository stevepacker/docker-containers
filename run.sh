#!/bin/sh


if [ -f "/app/package.json" ]; then
    cd /app

    if [ ! -d "/app/node_modules" ] || [ ! "$(ls -A /app/node_modules)" ]; then
        /usr/bin/npm install
    fi

    if [ "$SUPERVISOR" ]; then
        echo "Running with supervisor: $SUPERVISOR $SUPERVISORFLAGS npm run-script start"
        exec $SUPERVISOR $SUPERVISORFLAGS /usr/bin/npm run-script start
    else
        echo "Running without supervisor: npm run-script start"
        exec /usr/bin/npm run-script start
    fi
fi
