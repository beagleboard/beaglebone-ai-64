#!/bin/bash

sudo rm -f /boot/firmware/sysfw.itb ;\
sudo rm -f /boot/firmware/tiboot3.bin ;\
sudo rm -f /boot/firmware/tispl.bin ;\
sudo rm -f /boot/firmware/u-boot.img ;\
sync

sudo cp -v ./deploy/sysfw.itb /boot/firmware/ ;\
sudo cp -v ./deploy/tiboot3.bin /boot/firmware/ ;\
sudo cp -v ./deploy/tispl.bin /boot/firmware/ ;\
sudo cp -v ./deploy/u-boot.img /boot/firmware/ ;\
sync
