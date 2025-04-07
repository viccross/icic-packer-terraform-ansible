provider "openstack" {
  # Configuration options
  user_name   = "admin"
  #tenant_name = "admin"
  password    = var.openstack_password
  #auth_url    = "http://myauthurl:5000/v3"
  #region      = "RegionOne"
}