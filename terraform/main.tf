module "zvm_haproxy_guests" {
  source = "./modules/icic_haproxy_vm"
  for_each = var.haproxy_guests

  name = each.value.name
  image_timestamp = var.image_timestamp
}

module "zvm_vault_leader_guests" {
  source = "./modules/icic_vault_vm"
  for_each = var.vault_leader_guests

  name = each.value.name
  image_timestamp = var.image_timestamp
#  depends_on = [module.zvm_haproxy_guests.haproxy_instances]
}

module "zvm_vault_follower_guests" {
  source = "./modules/icic_vault_vm"
  for_each = var.vault_follower_guests

  name = each.value.name
  image_timestamp = var.image_timestamp
  leader_ip = module.zvm_vault_leader_guests["vm1"].ip_address
}
