#!/bin/bash

threads=4
memory_total=1G
block_sizes=(1K 2K 4K 8K)
access_modes=(seq rnd)

for block in "${block_sizes[@]}"
do
    for mode in "${access_modes[@]}"
    do
        echo "===== Testing block size $block, access mode $mode =====" >> mem.txt
        for run in 1 2
        do
            echo "Run #$run" >> mem.txt
            sysbench memory --threads=$threads --memory-block-size=$block \
                --memory-total-size=$memory_total --memory-access-mode=$mode --time=60 run >> mem.txt 2>&1
        done
    done
done