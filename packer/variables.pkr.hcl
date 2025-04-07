variable "source_image_name" {
  type        = string
  description = "Name of the source image to use for the build."
  default = "ubuntu-22.04"
}

variable "build_name" {
  type        = string
  description = "Name of the build."
  default = null 
}

variable "ssh_username" {
  type        = string
  description = "SSH username for the build."
  default = "ubuntu"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone where the build will be performed."
  default     = null #openstack availability zone required
}

variable "flavor" {
  type        = string
  description = "The flavor (instance type) to use for the build."
  default     = "m1.small"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security groups to apply to the build instance."
  default     = ["default"]
}