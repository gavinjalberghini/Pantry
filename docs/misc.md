# Misc Documentation

### Local K3s Install (k3sup)
```
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/
IP=$(hostname -i | awk '{print $2}')
mkdir ~/.kube
touch ~/.kube/config
k3sup install --ip $IP --user $USER --no-extras --local --local-path ~/.kube/config --merge
```

### Local K3s Shutdown & Clear
```
# stop
sudo systemctl stop k3s

# clear
/usr/local/bin/k3s-killall.sh
```

### Remote Join K3s Cluster (k3sup)
```
TBD
TODO: Configure Lima VM to see network of the host machine.
```

### Raw Pi Config Changes
```
sshpass -p xxxxxxxxxx ssh xxxxx@xxx.xxx.xxx.xxx "echo ' cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory' | sudo tee -a /boot/firmware/cmdline.txt"
```
