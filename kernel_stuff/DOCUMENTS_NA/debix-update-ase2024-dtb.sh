#!/bin/bash

dbxhost="debix@debix-nelis"
kdir="/home/nelis/Projects/2024/elebetavu/ase2024/debix/linux-kernel-6.1.22"

set -x

# Recompile dtb
pushd $kdir/linux-debix
make dtbs
popd

# Create remote dir and clean it
ssh $dbxhost "mkdir -p ~/tmp/debix-kernel"
ssh $dbxhost "rm -f ~/tmp/debix-kernel/*"

# Send ase2024 dtb file
scp $kdir/linux-debix/arch/arm64/boot/dts/freescale/imx8mp-debix-ase2024-debixboard.dtb $dbxhost:tmp/debix-kernel

# Copy it into place on the debix
ssh $dbxhost "sudo cp --no-preserve=mode,ownership ~/tmp/debix-kernel/imx8mp-debix-ase2024-debixboard.dtb /boot"
ssh $dbxhost "rm -f ~/tmp/debix-kernel/*"

