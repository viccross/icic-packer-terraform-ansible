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
    flavor_id = data.openstack_compute_flavor_v2.size.id
    network   = data.openstack_networking_network_v2.network.name
    # Add other fields that should trigger a new instance when changed
  }
}

resource "openstack_compute_instance_v2" "instance_rhl_wxk" {
  name      = "${var.project}${var.environment}${var.instance_purpose}${random_id.instance_suffix.hex}"
  image_id  = data.openstack_images_image_v2.img.id
  flavor_id = data.openstack_compute_flavor_v2.size.id
  network {
    name = "${data.openstack_networking_network_v2.network.name}"
  }
  availability_zone = var.availability_zone
}
