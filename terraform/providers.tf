provider "openstack" {
  # Configuration options
  user_name   = "admin"
  #tenant_name = "admin"
  password    = var.openstack_password
  auth_url    = "https://10.2.75.40"
  insecure   = true
  #region      = "RegionOne"
}