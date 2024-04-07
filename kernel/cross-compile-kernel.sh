#!/bin/bash

set -x

kdir="$(pwd)/linux-kernel-6.1.22/linux-debix"
config_path="$(pwd)/config-ase2024"
dtb_Makefile="$(pwd)/dts_Makefile"
dts_source="$(pwd)/imx8mp-debix-ase2024-debixboard.dts"

if [ ! -d "$kdir" ]; then
	cd linux-kernel-6.1.22 || mkdir linux-kernel-6.1.22 && cd linux-kernel-6.1.22

	
	echo "🟡 Kernel source setup"
	echo "🟡 Downloading linux source from debix"
	

	wget https://github.com/debix-tech/linux/archive/refs/heads/Model_AB-L6.1.22.zip
	unzip Model_AB-L6.1.22.zip
	mv linux-Model_AB-L6.1.22 linux-debix
	rm  Model_AB-L6.1.22.zip

fi

echo "🟡 Adding kernel config..."
cat $config_path > $kdir/.config

echo "🟡 Copying custom dts file..."
cp $dts_source $kdir/arch/arm64/boot/dts/freescale/

echo "🟡 Updating custom dts Makefile..."
cat $dtb_Makefile > $kdir/arch/arm64/boot/dts/freescale/Makefile




export PATH=/opt/toolchain-debix/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=/opt/toolchain-debix/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-

cd $kdir

make dtbs
if [ $? != 0 ]; then
	exit 2
fi

# Potentially add this if something fails, according to itsfoss.com
# ./scripts/config --file .config --disable MODULE_SIG

make -j$(nproc)
if [ $? != 0 ]; then
	exit 1
fi


make modules
if [ $? != 0 ]; then
	exit 2
fi



sudo rm -rf out
if [ $? != 0 ]; then
	exit 2
fi

sudo env PATH=$PATH make ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu-  INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=out modules_install
if [ $? != 0 ]; then
	exit 3
fi


cd $kdir/out/lib/modules

sudo tar -czvf 6.1.22-ase2024.tar.gz 6.1.22-ase2024


echo "🟡 Success, compiled kernel, modules and dtbs"

# scp 6.1.22-ase2024.tar.gz $dbxhost:tmp/
# ssh debix@debix-nelis "sudo mv /home/debix/tmp/6.1.22-ase2024.tar.gz /lib/modules; rm -rf /lib/modules/6.1.22-ase2024; cd /lib/modules; tar -xzvf 6.1.22-ase2024.tar.gz; rm 6.1.22-ase2024.tar.gz"


