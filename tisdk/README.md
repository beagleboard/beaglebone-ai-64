Download the latest eMMC flasher image:
* [eMMC flasher](https://rcn-ee.net/rootfs/debian-arm64/2022-04-04/j721e_evm-emmc-flasher-debian-11.3-xfce-arm64-2022-04-04-8gb.img.xz)

Flash with Balena Etcher:
* https://www.balena.io/etcher/

Power the board with the USER button pressed and the freshly programmed uSD card. After about 30 seconds, the LEDs should start lighting up in a sweeping pattern. Wait for the flashing to complete (LEDs stop flashing).

On x86 configure Docker:

```
echo $'{\n    "experimental": true\n}' | sudo tee /etc/docker/daemon.json
```
Then restart docker.service
```
sudo systemctl restart docker.service
```

Then build and extract the tarballs
```
./build.sh
./extract_visionapps.sh
```

On BeagleBone AI-64:
* username: debian, password: temppwd
* Make sure Docker points to a 64GB or more storage area based on the current scripts.
* You'll need at least 2GB of swapfile to build this image.
* Copy the \*.tar.xz files from x86

example:
```
debian@BeagleBone:~$ cat /etc/docker/daemon.json 
{
	"data-root": "/opt/sandisk/docker"
}

debian@BeagleBone:~$ cat /etc/fstab 
# /etc/fstab: static file system information.
#
/dev/mmcblk0p2  /  ext4  noatime,errors=remount-ro  0  1
/dev/mmcblk0p1  /boot/firmware vfat defaults 0 0
debugfs  /sys/kernel/debug  debugfs  mode=755,uid=root,gid=gpio,defaults  0  0
UUID=421a6bb7-ca9b-4ce1-90f2-0c1d65c2dacd /opt/sandisk ext4 defaults 0 2
# a swapfile is not a swap partition, no line here
#   use  dphys-swapfile swap[on|off]  for that
```

```
./build.sh
./run.sh
```

