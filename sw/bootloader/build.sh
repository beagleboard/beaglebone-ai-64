#!/bin/bash

#Requires:
#Debian 11.x:
#sudo apt update
#sudo apt install bc bison flex libssl-dev u-boot-tools python3-pycryptodome python3-pyelftools binutils-arm-linux-gnueabihf binutils-aarch64-linux-gnu gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu tree

DIR="$PWD"

mkdir -p ./deploy/

if [ -d ./tmp/ti-linux-firmware/ ] ; then
	rm -rf ./tmp/ti-linux-firmware/ || true
fi

if [ ! -f ./deploy/ipc_echo_testb_mcu1_0_release_strip.xer5f ] ; then
	mkdir -p ./tmp/ti-linux-firmware/
	git clone -b 08.03.00.003 https://git.ti.com/git/processor-firmware/ti-linux-firmware.git --depth=1 ./tmp/ti-linux-firmware/
	cp -v ./tmp/ti-linux-firmware/ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f ./deploy/
fi

if [ -d ./tmp/arm-trusted-firmware/ ] ; then
	rm -rf ./tmp/arm-trusted-firmware/ || true
fi

if [ ! -f ./deploy/bl31.bin ] ; then
	mkdir -p ./tmp/arm-trusted-firmware/
	git clone -b bbb.io-08.01.00.006 https://git.beagleboard.org/beagleboard/arm-trusted-firmware.git --depth=1 ./tmp/arm-trusted-firmware/
	make -C tmp/arm-trusted-firmware -j4 CROSS_COMPILE=aarch64-linux-gnu- CFLAGS= LDFLAGS= ARCH=aarch64 PLAT=k3 TARGET_BOARD=generic SPD=opteed all
	cp -v ./tmp/arm-trusted-firmware/build/k3/generic/release/bl31.bin ./deploy/
fi

if [ -d ./tmp/optee_os/ ] ; then
	rm -rf ./tmp/optee_os/ || true
fi

if [ ! -f ./deploy/tee-pager_v2.bin ] ; then
	mkdir -p ./tmp/optee_os/
	git clone -b 08.01.00.005 https://git.beagleboard.org/beagleboard/optee_os.git --depth=1 ./tmp/optee_os/
	make -C tmp/optee_os -j4 CFLAGS= LDFLAGS= PLATFORM=k3-j721e CFG_ARM64_core=y
	cp -v ./tmp/optee_os/out/arm-plat-k3/core/tee-pager_v2.bin ./deploy/
fi

if [ -d /tmp/k3-image-gen ] ; then
	rm -rf /tmp/k3-image-gen || true
fi

if [ ! -f ./deploy/sysfw.itb ] ; then
	mkdir -p ./tmp/k3-image-gen/
	git clone -b 08.01.00.006 https://github.com/beagleboard/k3-image-gen --depth=1 ./tmp/k3-image-gen/
	make -C tmp/k3-image-gen/ SOC=j721e CONFIG=evm CROSS_COMPILE=arm-linux-gnueabihf-
	cp -v ./tmp/k3-image-gen/sysfw.itb ./deploy/
fi


if [ -d ./tmp/u-boot/ ] ; then
	rm -rf ./tmp/u-boot/ || true
fi


if [ ! -f ./deploy/u-boot.img ] ; then
	mkdir -p ./tmp/u-boot/
	git clone -b v2021.01-ti-08.01.00.006 https://git.beagleboard.org/beagleboard/u-boot.git --depth=1 ./tmp/u-boot/

	if [ ! -f ./deploy/tiboot3.bin ] ; then
		make -C ./tmp/u-boot -j1 O=../r5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- j721e_evm_r5_defconfig
		make -C ./tmp/u-boot -j5 O=../r5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
		cp -v tmp/r5/tiboot3.bin deploy/
	fi

	make -C ./tmp/u-boot -j1 O=../a72 ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- j721e_evm_a72_defconfig
	make -C ./tmp/u-boot -j5 O=../a72 ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- ATF=${DIR}/deploy/bl31.bin TEE=${DIR}/deploy/tee-pager_v2.bin DM=${DIR}/deploy/ipc_echo_testb_mcu1_0_release_strip.xer5f
	cp -v ./tmp/a72/tispl.bin ./deploy/
	cp -v ./tmp/a72/u-boot.img ./deploy/
fi

tree ./deploy/
