## Variables file

variable "image_timestamp" {
  description = "Timestamp of the images"
  type        = string
  default     = "2025-06-07_02-35-12"
}

variable "openstack_password" {
  description = "OpenStack password"
  type        = string
}

variable "vault_leader_guests" {
  description = "Definitions of the Vault leader VMs needed"
  type = map(any)

  default = {
    vm1 = {
      name = "demo-vault-1"
    }
  }
}

variable "vault_follower_guests" {
  description = "Definitions of the Vault follower VMs needed"
  type = map(any)

  default = {
    vm2 = {
      name = "demo-vault-2"
    },
    vm3 = {
      name = "demo-vault-3"
    }
  }
}

variable "haproxy_guests" {
  description = "Definitions of the HAProxy VMs needed"
  type = map(any)

  default = {
    vm1 = {
      name = "demo-vault-haproxy"
    }
  }
}

