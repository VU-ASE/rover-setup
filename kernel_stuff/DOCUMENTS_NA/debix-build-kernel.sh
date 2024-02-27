#!/bin/bash

dbxhost="debix@debix-nelis"
kdir="/home/nelis/Projects/2024/elebetavu/ase2024/debix/linux-kernel-6.1.22"

export PATH=/opt/toolchain-debix/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=/opt/toolchain-debix/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-

pushd $kdir

make -j8 
if [ $? != 0 ]; then
	exit 1
fi

make modules
if [ $? != 0 ]; then
	exit 2
fi

rm -rf out
if [ $? != 0 ]; then
	exit 2
fi

sudo env PATH=$PATH make ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu-  INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=out modules_install
if [ $? != 0 ]; then
	exit 3
fi

cd out/lib/6.1.22-ase2024/modules
tar -czvf 6.1.22-ase2024.tar.gz 6.1.22-ase2024
scp 6.1.22-ase2024.tar.gz $dbxhost:tmp/
ssh debix@debix-nelis "sudo mv /home/debix/tmp/6.1.22-ase2024.tar.gz /lib/modules; rm -rf /lib/modules/6.1.22-ase2024; cd /lib/modules; tar -xzvf 6.1.22-ase2024.tar.gz; rm 6.1.22-ase2024.tar.gz"

popd
