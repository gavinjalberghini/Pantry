# GPG SOPS

## Install
```
SOPS_LATEST_VERSION=$(curl -s "https://api.github.com/repos/getsops/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo sops.deb "https://github.com/getsops/sops/releases/download/v${SOPS_LATEST_VERSION}/sops_${SOPS_LATEST_VERSION}_amd64.deb"
sudo apt --fix-broken install ./sops.deb
rm -rf sops.deb
sops -version
```

## Import
```
gpg --import privatekeys.asc
gpg --import pubkeys.asc
gpg -K
gpg -k
gpg --import-ownertrust otrust.txt
```

## Export
```
gpg -a --export > pubkeys.asc
gpg -a --export-secret-keys > privatekeys.asc
gpg --export-ownertrust > otrust.txt
```

## Set Shell
```
export SOPS_PGP_FP="sops-gpg-fingerprint"
```

## Encrypt
```
sops --encrypt sec.yaml > sec.enc.yaml
```

## Decrypt
```
sops --decrypt sec.enc.yaml > sec.yaml
```

## Get Fingerprint
```
gpg --fingerprint (key_name) | awk 'NR==2 {print $1$2$3$4$5$6$7$8$9$10}'
```
