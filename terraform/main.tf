data "openstack_images_image_v2" "img" {
  name        = "zrhimg1"
  most_recent = true
}

#
data "openstack_compute_flavor_v2" "size" {
  name = "tiny"
}

data "openstack_networking_network_v2" "network" {
  name = "StLeoLAN75"
}


resource "random_id" "instance_suffix" {
  byte_length = 3
  keepers = {
    # Any changes to these values will generate a new ID
    image_id  = data.openstack_images_image_v2.img.id
    flavor_id = data.openstack_flavors_flavor_v2.small.id
    network   = data.openstack_networking_network_v2.network.name
    # Add other fields that should trigger a new instance when changed
  }
}

resource "openstack_compute_instance_v2" "instance_rhl_wxk" {
  name      = "${var.environment}-${var.project}-${var.instance_purpose}-${random_id.instance_suffix.hex}"
  image_id  = data.openstack_images_image_v2.img.id
  flavor_id = data.openstack_flavors_flavor_v2.small.id
  network {
    name = "${data.openstack_networking_network_v2.network.name}"
  }
}

output "network_name" {
  description = "The name of the OpenStack network"
  value       = data.openstack_networking_network_v2.network.name
}

output "openstack_flavour_id" {
  description = "The ID of the OpenStack image"
  value       = data.openstack_flavors_flavor_v2.small.id
}

output "openstack_image_id" {
  description = "The ID of the OpenStack image"
  value       = data.openstack_images_image_v2.img.id
}