provider "openstack" {
  # Configuration options
  user_name   = "root"
  tenant_name = "ibm-default"
  password    = var.openstack_password
  auth_url    = "https://iim1mgt1.z.stg.ibm/iim/openstack/identity/v3"
  domain_name = "Default"
  insecure   = true
}