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

# data "amazon-ami" "ubuntu" {
#   region      = var.region
#   filters     = var.ami_filter
#   most_recent = true
#   owners      = [var.ami_owner]
# }

# locals {
#   timestamp = formatdate("YYYY-MM-DD_hh-mm-ss", timestamp())
#   ami_name  = "${var.ami_name}_${local.timestamp}"
# }
locals {
  build_name = var.build_name == null ? "${var.os_name}-${var.os_version}" : var.build_name
}

source "openstack" "vm" {
  availability_zone    = var.availability_zone
  flavor               = var.flavor
  image_name           = local.build_name
  security_groups      = local.security_groups
  source_image_name    = var.source_image_name
  ssh_username         = var.ssh_username
}




# source "amazon-ebs" "img" {
#   ami_name      = local.ami_name
#   instance_type = var.instance_type
#   region        = var.region
#   source_ami    = data.amazon-ami.ubuntu.id
#   ssh_username  = var.ssh_username
#   associate_public_ip_address = true
#   # subnet_id = var.public_subnet_id
#   # vpc_id = var.vpc_id
# }

# build {
#   name = var.ami_name

#   hcp_packer_registry {
#     bucket_name = var.ami_name
#     description = "Ubuntu 2204 AWS AMI with docker and Vault ssh signing prereqs"

#     bucket_labels = {
#       owner   = "SKO"
#       os      = "Ubuntu"
#       version = "22.04"
#     }

#     build_labels = {
#       timestamp = local.timestamp
#     }
#   }

#   provisioner "ansible" {
#     playbook_file = "${path.cwd}/ansible/playbook.yml"

#     ansible_env_vars = [
#       "ANSIBLE_DEPRECATION_WARNINGS=False",
#       "ANSIBLE_HOST_KEY_CHECKING=False",
#       "ANSIBLE_NOCOLOR=True",
#       "ANSIBLE_NOCOWS=1",
#       "VAULT_NAMESPACE=${var.vault_namespace}",
#       "VAULT_URL=${var.vault_url}",
#       "ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3"
#     ]

#     extra_arguments = [
#       "--ssh-extra-args",
#       "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa -o IdentitiesOnly=yes",
#       "--scp-extra-args",
#       "'-O'"
#     ]
#   }

#   sources = [
#     "source.amazon-ebs.img"
#   ]
# }