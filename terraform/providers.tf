provider "openstack" {
  # Configuration options
  user_name   = "root"
  tenant_name = "ibm-default"
  password    = var.openstack_password
  auth_url    = "https://icicmgt1.z.stg.ibm/icic/openstack/identity/v3"
  domain_name = "Default"
  insecure   = true
}