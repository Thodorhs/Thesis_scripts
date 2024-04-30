#!/usr/bin/env bash

out="/archive/users/thodp/NBDnvme"
device="nbd0"
block_size=4
iodepth=1
numjobs=1
output_dir="$out/flame_graph_randreads/iodepth_$iodepth/request_size_$block_size"

mkdir -p "$output_dir"

BLOCK_SIZE="${block_size}k" SIZE='50%' DEVICE="$device" IODEPTH="$iodepth" NJOBS="$numjobs" \
    fio scripts/rand-read.fio --output="$output_dir/fio_out.txt" & 

pid=$!
sleep 1

sudo perf record -F 1000 -g -p $pid -o "$output_dir/blk_perf.data"
#sudo perf record -e 'net:*' -p $pid -o "$output_dir/net_perf.data"
sudo perf script -i "$output_dir/blk_perf.data" | ./FlameGraph/stackcollapse-perf.pl | ./FlameGraph/flamegraph.pl > "$output_dir/blk_flamegraph.svg"
#sudo perf script -i "$output_dir/net_perf.data" | ./FlameGraph/stackcollapse-perf.pl | ./FlameGraph/flamegraph.pl > "$output_dir/net_flamegraph.svg"
