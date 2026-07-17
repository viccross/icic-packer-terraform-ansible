packer {
  required_plugins {
    openstack = {
      version = "~> 1"
      source  = "github.com/hashicorp/openstack"
    }

    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
  required_version = "~> 1.11"
}

locals {
  timestamp  = formatdate("YYYY-MM-DD_hh-mm-ss", timestamp())
  vault_build_name = "${var.source_image_name}_vault_${local.timestamp}"
  haproxy_build_name = "${var.source_image_name}_haproxy_${local.timestamp}"
}


source "openstack" "infra_cloud_center" {
  identity_endpoint = var.identity_endpoint
  username          = var.username
  password          = var.password
  tenant_name       = var.tenant_name
  domain_name       = var.domain_name
  insecure          = var.insecure
  availability_zone = var.availability_zone
  flavor            = var.flavor
  source_image_name = var.source_image_name
  ssh_username      = var.ssh_username
  networks          = var.networks
}


build {
  name = "demo_packer_build"

  provisioner "shell" {
    inline = ["dnf -y install python36"]
  }

  provisioner "ansible" {
    playbook_file = "${path.cwd}/ansible/playbook.yml"

    ansible_env_vars = [
      "ANSIBLE_DEPRECATION_WARNINGS=False",
      "ANSIBLE_HOST_KEY_CHECKING=False",
      "ANSIBLE_NOCOLOR=True",
      "ANSIBLE_NOCOWS=1",
      "ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3",
      "MY_BUILD_NAME=${source.name}"
    ]

    extra_arguments = [
      "--ssh-extra-args",
      "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa -o IdentitiesOnly=yes"
    ]
  }

  source "source.openstack.infra_cloud_center" {
    name       = "vault_build"
    image_name = local.vault_build_name
  }
# No need to build a haproxy image... but it means we always need
#   "most_recent", or separate image tags for vault and haproxy
#  source "source.openstack.infra_cloud_center" {
#    name       = "haproxy_build"
#    image_name = local.haproxy_build_name
  }
}
