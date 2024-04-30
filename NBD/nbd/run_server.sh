#!/bin/bash

log_path="logs.bin"

if [ -f "$log_path" ]; then
    echo "Clearing prev logs..."
    echo "Don't forget to give permision to user running server."
    truncate -s 0 "$log_path"
fi
nbd-server -C /home1/public/thodp/nbd/config
