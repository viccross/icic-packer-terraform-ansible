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

variable "vault_guests" {
  description = "Definitions of the Apache VMs needed"
  type = map(any)

  default = {
    vm1 = {
      name = "vault-1"
    },
    vm2 = {
      name = "vault-2"
    },
    vm3 = {
      name = "vault-3"
    }
  }
}

variable "haproxy_guests" {
  description = "Definitions of the HAProxy VMs needed"
  type = map(any)

  default = {
    vm1 = {
      name = "haproxy-vault"
    }
  }
}

