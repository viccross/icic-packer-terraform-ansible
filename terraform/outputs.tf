output "vm_name" {
  description = "The name of the OpenStack instance created"
  value       = "${var.environment}-${var.project}-${var.instance_purpose}-${random_id.instance_suffix.hex}"
}

output "network_name" {
  description = "The name of the OpenStack network"
  value       = data.openstack_networking_network_v2.network.name
}

output "openstack_flavour_id" {
  description = "The ID of the OpenStack flavour"
  value       = data.openstack_compute_flavor_v2.size.id
}

output "openstack_image_id" {
  description = "The ID of the OpenStack image"
  value       = data.openstack_images_image_v2.img.id
}