On x86 configure Docker:

```
echo $'{\n    "experimental": true\n}' | sudo tee /etc/docker/daemon.json
```
Then restart docker.service
```
sudo systemctl restart docker.service
```

On x86:
```
./build.sh
./extract_visionapps.sh
```

Copy the *.tar.xz files to BB-AI-64

On BB-AI-64:
```
./build.sh
./run.sh
```

