export PACKER_VERSION=1.12.0
wget --quiet "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"
unzip packer_${TERRAFORM_VERSION}_linux_amd64.zip
#sudo mv terraform /usr/local/bin