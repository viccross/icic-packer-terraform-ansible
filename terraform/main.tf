
module "zvm_vault_guests" {
  source = "./modules/icic_vault_vm"
  for_each = var.vault_guests

  name = each.value.name
  image_timestamp = var.image_timestamp
#  depends_on = [module.zvm_haproxy_guests.haproxy_instances]
}

module "zvm_haproxy_guests" {
  source = "./modules/icic_haproxy_vm"
  for_each = var.haproxy_guests

  name = each.value.name
  image_timestamp = var.image_timestamp
}
