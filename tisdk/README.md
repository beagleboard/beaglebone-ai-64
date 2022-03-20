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

