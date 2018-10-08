#!/usr/bin/env bash

function generate_dts {
    DTB_PATH=$1
    cd $DTB_PATH
    for DTB in $(ls *.dtb*)
    do
        DT_NAME="${DTB%.*}"
        if ! dtc -I dtb -O dts -o ${DT_NAME}.dts ${DTB} &> /dev/null ; then
        	echo "failed to convert ${DTB} to dts"
        fi
    done
    cd -
}

# Relies on Dockerfile setting DT_SANDBOX
# Also platform specific with the partition to be mounted... hmm

mkdir -p /mnt/part
mount /dev/mmcblk2p1 /mnt/part
cp -f /mnt/part/fdt_overlays/* ${DT_SANDBOX}/sys-overlays 2> /dev/null || echo "No system overlays found (OK)"
cp -f /mnt/part/*.dtb ${DT_SANDBOX}/sys-device-trees 2> /dev/null || echo "No system device trees found (Odd)"


generate_dts ${DT_SANDBOX}/sys-device-trees
# Doesn't work on overlays :(
#generate_dts ${DT_SANDBOX}/sys-overlays
#generate_dts ${DT_SANDBOX}/overlays