Download the latest eMMC flasher image:
* [eMMC flasher](https://rcn-ee.net/rootfs/debian-arm64/2022-04-04/j721e_evm-emmc-flasher-debian-11.3-xfce-arm64-2022-04-04-8gb.img.xz)

Flash with Balena Etcher:
* https://www.balena.io/etcher/

Boot the board with the freshly programmed uSD card and wait for the flashing to complete (LEDs stop flashing).

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
* Make sure Docker points to a 64GB or more storage area based on the current scripts.
* You'll need at least 2GB of swapfile to build this image.
* Copy the \*.tar.xz files from x86

```
./build.sh
./run.sh
```

