output "vault_leader_instances" {
  description = "Full instance details"
  value       = module.zvm_vault_leader_guests
}

output "vault_follower_instances" {
  description = "Full instance details"
  value       = module.zvm_vault_follower_guests
}

output "haproxy_instances" {
  description = "Full instance details"
  value       = module.zvm_haproxy_guests
}

