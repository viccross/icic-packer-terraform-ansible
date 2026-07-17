output "vault_instances" {
  description = "Full instance details"
  value       = module.zvm_vault_guests
}

output "haproxy_instances" {
  description = "Full instance details"
  value       = module.zvm_haproxy_guests
}

