#!/usr/bin/with-contenv sh

if [ -n "$APKS" ]; then
    exec apk -U add $APKS
fi