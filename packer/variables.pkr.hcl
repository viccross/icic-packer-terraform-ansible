variable "source_image_name" {
  type        = string
  description = "Name of the source image to use for the build."
  default     = "zrhimg1"
}

variable "build_name" {
  type        = string
  description = "Name of the build."
  default     = null
}

variable "ssh_username" {
  type        = string
  description = "SSH username for the build."
  default     = "root"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone where the build will be performed."
  default     = "Default Group" #openstack availability zone required
}

variable "flavor" {
  type        = string
  description = "The flavor (instance type) to use for the build."
  default     = "tiny"
}

variable "identity_endpoint" {
  type        = string
  description = "The OpenStack identity endpoint."
  default     = "https://icicmgt1.z.stg.ibm/icic/openstack/identity/v3"
}

variable "username" {
  type        = string
  description = "The OpenStack username."
  default     = "root"
}

variable "password" {
  type        = string
  description = "The OpenStack password."
}

variable "tenant_name" {
  type        = string
  description = "The OpenStack tenant name."
  default     = "ibm-default"
}

variable "domain_name" {
  type        = string
  description = "The OpenStack domain name."
  default     = "Default"
}

variable "insecure" {
  type        = bool
  description = "Whether to skip SSL verification."
  default     = true
}

# variable "security_groups" {
#   type        = list(string)
#   description = "List of security groups to apply to the build instance."
#   default     = ["default"]
# }

variable "networks" {
  type    = list(string)
  default = ["f0159cc1-07ea-4adb-be06-a454fa467d03"]
}
