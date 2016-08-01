#!/bin/sh

case "$@" in
    --\ *)
        sh -c "$@"
        ;;
    *)
        exec git "$@"
        ;;
esac
