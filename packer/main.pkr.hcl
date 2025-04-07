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

locals {
  timestamp = formatdate("YYYY-MM-DD_hh-mm-ss", timestamp())
  build_name  = "${var.source_image_name}_${local.timestamp}"
}


source "openstack" "infra_cloud_center" {
  identity_endpoint = var.identity_endpoint
  insecure = var.insecure
  availability_zone    = var.availability_zone
  flavor               = var.flavor
  image_name           = local.build_name
  security_groups      = var.security_groups
  source_image_name    = var.source_image_name
  ssh_username         = var.ssh_username
}


build {
  name = local.build_name

  provisioner "ansible" {
    playbook_file = "${path.cwd}/ansible/playbook.yml"

    ansible_env_vars = [
      "ANSIBLE_DEPRECATION_WARNINGS=False",
      "ANSIBLE_HOST_KEY_CHECKING=False",
      "ANSIBLE_NOCOLOR=True",
      "ANSIBLE_NOCOWS=1",
      # "VAULT_NAMESPACE=${var.vault_namespace}",
      # "VAULT_URL=${var.vault_url}",
      "ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3"
    ]

    extra_arguments = [
      "--ssh-extra-args",
      "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa -o IdentitiesOnly=yes",
      "--scp-extra-args",
      "'-O'"
    ]
  }

  sources = [
    "source.openstack.infra_cloud_center"
  ]
}