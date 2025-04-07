provider "openstack" {
  # Configuration options
  user_name   = "admin"
  tenant_name = "ibm-default"
  password    = var.openstack_password
  auth_url    = "https://10.2.75.40icic/openstack/identity/v3"
  domain_name = "Default"
  insecure   = true
}