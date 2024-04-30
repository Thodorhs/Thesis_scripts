#!/bin/bash

if [ -f "a.out" ]; then
    rm a.out
fi

if [ -f "/mnt/fmap/DirectIO/directIO.txt" ]; then
	rm /mnt/fmap/DirectIO/directIO.txt
fi

gcc -D_GNU_SOURCE testIO.c -o a.out

touch /mnt/fmap/DirectIO/directIO.txt
