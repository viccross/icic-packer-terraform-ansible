## Variables file

variable "openstack_password" {
  description = "OpenStack password"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "instance_purpose" {
  description = "Purpose of the instance (e.g. web, app, db)"
  type        = string
  default     = "demo"
}

variable "project" {
  description = "Project identifier"
  type        = string
  default     = "prj"
}