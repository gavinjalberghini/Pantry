# Misc Documentation

### Local K3s Install (k3sup)
```
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/
```

### Raw Pi Config Changes
```
sshpass -p xxxxxxxxxx ssh xxxxx@xxx.xxx.xxx.xxx "echo ' cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory' | sudo tee -a /boot/firmware/cmdline.txt"
```
