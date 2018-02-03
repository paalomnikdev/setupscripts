#!/bin/bash
read -d "\0" -a number_of_gpus < <(nvidia-smi --query-gpu=count --format=csv,noheader,nounits)
printf "%s\n" "found ${number_of_gpus[0]} gpu[s]..."
index=$(( number_of_gpus[0] - 1 ))
for i in $(seq 0 $index)
do
    printf "%s\n" "found GeForce GTX 1070 at index $i..."
    printf "%s\n" "setting persistence mode..."
    nvidia-smi -i $i -pm 1
    printf "%s\n" "setting power limit to 95 watts.."
    nvidia-smi -i $i -pl 95
    printf "%s\n" "setting memory overclock of 500 Mhz..."
    nvidia-settings -a [gpu:${i}]/GPUMemoryTransferRateOffset[3]=500
    nvidia-settings -a [gpu:${i}]/GPUGraphicsClockOffset[3]=100
    nvidia-settings -a [gpu:${i}]/GPUMemoryTransferRateOffset[2]=500
    nvidia-settings -a [gpu:${i}]/GPUGraphicsClockOffset[2]=100
    nvidia-settings -a [gpu:${i}]/GPUFanControlState=1 -a [fan-${i}]/GPUTargetFanSpeed=80
done
