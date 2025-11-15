#!/bin/bash

TEST_DIR="./fileio_test"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR" || exit 1

threads_list=(1 32 32)
bs_list=(4K 128K 4K)
modes=(seqrd seqwr rndrd rndwr)

for i in "${!threads_list[@]}"; do
    threads=${threads_list[$i]}
    bs=${bs_list[$i]}

    for mode in "${modes[@]}"; do
        echo "===== Testing threads $threads, block size $bs, mode $mode =====" >> io.txt
        for run in 1 2; do
            echo "Run #$run" >> io.txt
            sysbench fileio \
              --file-total-size=300M \
              --file-block-size="$bs" \
              prepare > /dev/null 2>&1

            sysbench fileio \
              --threads="$threads" \
              --file-total-size=300M \
              --file-block-size="$bs" \
              --file-test-mode="$mode" \
              --time=60 \
              run >> io.txt 2>&1

            sysbench fileio cleanup > /dev/null 2>&1
        done
    done
done
EOF