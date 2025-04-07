TERRAFORM_VERSION=1.11.2
wget --quiet "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
mv terraform /usr/local/bin \
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip