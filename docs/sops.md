# GPG SOPS

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
