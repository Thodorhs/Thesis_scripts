#!/bin/bash

if [ -f "a.out" ]; then
    rm a.out
fi

if [ -f "/mnt/fmap/BufferedIO/bufferedIO.txt" ]; then
	rm /mnt/fmap/BufferedIO/bufferedIO.txt
fi

gcc testIO.c -o a.out

touch /mnt/fmap/BufferedIO/bufferedIO.txt
