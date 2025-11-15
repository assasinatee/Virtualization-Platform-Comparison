#!/bin/bash

for threads in 1 4 16 32 64
do
    echo "===== Testing with $threads threads =====" >> cpu.txt
    for run in 1 2
    do
        echo "Run #$run" >> cpu.txt
        sysbench cpu --cpu-max-prime=10000 --threads=$threads run >> cpu.txt 2>&1
    done
done