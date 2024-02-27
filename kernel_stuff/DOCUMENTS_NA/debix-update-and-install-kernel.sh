#!/bin/bash

export PATH=/opt/toolchain-debix/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=/opt/toolchain-debix/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-

dbxhost="debix@debix-nelis"
kdir="/home/nelis/Projects/2024/elebetavu/ase2024/debix/linux-kernel-6.1.22"

set -x

###
### Build time
###

# Build kernel and modules
cd $kdir/linux-debix
make -j8 
if [ $? != 0 ]; then
	exit 1
fi

# Do something with modules
make modules
if [ $? != 0 ]; then
	exit 2
fi

# Clear output dir
rm -rf out
if [ $? != 0 ]; then
	exit 2
fi

# Install modules to out dir
make ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu-  INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=out modules_install
if [ $? != 0 ]; then
	exit 3
fi

# Tar the archives so we can send them over to the debix board later
rm -f $kdir/linux-debix/out/lib/modules/6.1.22-ase2024.tar.gz
cd $kdir/linux-debix/out/lib/modules
tar -czvf 6.1.22-ase2024.tar.gz 6.1.22-ase2024

###
### Transfer time
###

# Create remote dir on debix and clean it
ssh $dbxhost "mkdir -p ~/tmp/debix-kernel"
ssh $dbxhost "rm -f ~/tmp/debix-kernel/*"

# Send kernel image 
scp $kdir/linux-debix/arch/arm64/boot/Image $dbxhost:tmp/debix-kernel/

# Copy kernel into place on the debix
ssh $dbxhost "sudo cp --no-preserve=mode,ownership ~/tmp/debix-kernel/* /boot"
ssh $dbxhost "rm -f ~/tmp/debix-kernel/*"

# Send dtb files and copy imx8mp-debix-ase2024-debixboard.dtb to imx8mp-evk.dtb so uboot will load it (it's the default name for this uboot)
scp $kdir/linux-debix/arch/arm64/boot/dts/freescale/*debix*.dtb $kdir/linux-debix/arch/arm64/boot/dts/freescale/imx8mp-evk.dtb $dbxhost:tmp/debix-kernel
ssh $dbxhost "sudo rm /boot/*.dtb"
ssh $dbxhost "sudo cp --no-preserve=mode,ownership tmp/debix-kernel/*.dtb /boot"
ssh $dbxhost "sudo mv /boot/imx8mp-evk.dtb /boot/imx8mp-evk.dtb.orig"
ssh $dbxhost "sudo cp --no-preserve=mode,ownership tmp/debix-kernel/imx8mp-debix-ase2024-debixboard.dtb /boot/imx8mp-evk.dtb"
ssh $dbxhost "rm tmp/debix-kernel/*.dtb"

# Install modules on the debix board
scp $kdir/linux-debix/out/lib/modules/6.1.22-ase2024.tar.gz $dbxhost:tmp/debix-kernel
ssh $dbxhost "sudo rm -rf /lib/modules/6.1.22-ase2024"
ssh $dbxhost "sudo tar -xzvf tmp/debix-kernel/6.1.22-ase2024.tar.gz -C /lib/modules"
ssh $dbxhost "rm tmp/debix-kernel/6.1.22-ase2024.tar.gz"

