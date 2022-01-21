#!/bin/bash

#Requires:
#bc bison flex libssl-dev u-boot-tools python3-pycryptodome python3-pyelftools
#binutils-arm-linux-gnueabihf binutils-aarch64-linux-gnu
#gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu
#bb-u-boot-j721e-evm

DIR="$PWD"

if [ -d ./k3-image-gen ] ; then
	rm -rf ./k3-image-gen || true
fi

#https://git.ti.com/gitweb?p=arago-project/meta-ti.git;a=tree;f=recipes-bsp/ti-sci-fw;hb=HEAD
#https://git.ti.com/gitweb?p=arago-project/meta-ti.git;a=blob;f=recipes-bsp/ti-linux-fw/ti-linux-fw.inc;hb=HEAD
#https://git.ti.com/gitweb?p=k3-image-gen/k3-image-gen.git;a=summary

#2022.01.21 -> 489c767a153ff26e9230746e04dd4b1ad0809901
#08.00.00.004 -> 08.01.00.006
#https://github.com/beagleboard/k3-image-gen/compare/08.00.00.004...08.01.00.006
git clone -b 08.01.00.006 https://github.com/beagleboard/k3-image-gen --depth=10
cd ./k3-image-gen/
make SOC=j721e CONFIG=evm CROSS_COMPILE=arm-linux-gnueabihf-
cp -v sysfw.itb ../deploy/
cd ../

if [ -d ./arm-trusted-firmware ] ; then
	rm -rf ./arm-trusted-firmware || true
fi

#https://git.ti.com/gitweb?p=atf/arm-trusted-firmware.git;a=summary
#https://git.ti.com/gitweb?p=atf/arm-trusted-firmware.git;a=shortlog;h=refs/tags/08.01.00.006
git clone -b bbb.io-08.01.00.006 https://github.com/beagleboard/arm-trusted-firmware --depth=10
cd ./arm-trusted-firmware/
make -j4 CROSS_COMPILE=aarch64-linux-gnu- ARCH=aarch64 PLAT=k3 TARGET_BOARD=generic SPD=opteed all
cp -v build/k3/generic/release/bl31.bin ../deploy/
cd ../

if [ -d ./optee_os ] ; then
	rm -rf ./optee_os || true
fi

git clone -b 3.12.0 https://github.com/beagleboard/optee_os --depth=10
cd ./optee_os/
make -j4 PLATFORM=k3-j721e CFG_ARM64_core=y
cp -v out/arm-plat-k3/core/tee-pager_v2.bin ../deploy/
cd ../

if [ -d ./u-boot ] ; then
	rm -rf ./u-boot || true
fi

git clone -b v2021.01-ti-08.00.00.004 https://github.com/beagleboard/u-boot --depth=10
cd ./u-boot/
make CROSS_COMPILE=arm-linux-gnueabihf- j721e_evm_r5_defconfig O=/tmp/r5
make -j4 CROSS_COMPILE=arm-linux-gnueabihf- O=/tmp/r5
cp -v /tmp/r5/tiboot3.bin ../deploy/
make CROSS_COMPILE=aarch64-linux-gnu- j721e_evm_a72_defconfig O=/tmp/a72
echo "make ATF=${DIR}/deploy/bl31.bin TEE=${DIR}/deploy/tee-pager_v2.bin DM=/opt/u-boot/bb-u-boot-j721e-evm/ipc_echo_testb_mcu1_0_release_strip.xer5f O=/tmp/a72"
make -j4 CROSS_COMPILE=aarch64-linux-gnu- ATF=${DIR}/deploy/bl31.bin TEE=${DIR}/deploy/tee-pager_v2.bin DM=/opt/u-boot/bb-u-boot-j721e-evm/ipc_echo_testb_mcu1_0_release_strip.xer5f O=/tmp/a72
cp -v /tmp/a72/tispl.bin ../deploy/
cp -v /tmp/a72/u-boot.img ../deploy/
cd ../
