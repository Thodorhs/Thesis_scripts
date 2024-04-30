#!/bin/bash

sudo nbd-client -C 32 -b 512 sith6-fast -N export /dev/nbd0 
