# Packer on IBM Cloud Infrastucture Center

```zsh
# on mac only
brew tap hashicorp/tap
brew install hashicorp/tap/packer
brew install ansible
```

```zsh
cd packer
export PKR_VAR_password="<icic password>"
./packer init .
./packer validate .
./packer build .
```
