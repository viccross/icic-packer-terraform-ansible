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

variable "" {
}