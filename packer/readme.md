# Packer on IBM Cloud Infrastucture Center

```zsh
# on mac only
brew tap hashicorp/tap
brew install hashicorp/tap/packer
brew install ansible
```

##
```zsh

# Ubuntu
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible

#Centos
sudo yum update -y
sudo yum install epel-release
sudo yum install ansible
```


```zsh
cd packer
export PKR_VAR_password="<ICIC/Openstack password>"
./packer init .
./packer validate .
./packer build .
```
