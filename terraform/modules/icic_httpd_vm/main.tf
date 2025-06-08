data "openstack_images_image_v2" "img" {
  name_regex  = "^zrhimg1_httpd_.*"
  most_recent = true
}

#
data "openstack_compute_flavor_v2" "size" {
  name = "tiny"
}

data "openstack_networking_network_v2" "network" {
  name = "StLeoLAN75"
}

data "openstack_compute_keypair_v2" "my_keypair" {
  name       = "valhalla-keypair"
}

resource "openstack_compute_instance_v2" "zvm_instance" {
  name      = var.name
  image_id  = data.openstack_images_image_v2.img.id
  flavor_id = data.openstack_compute_flavor_v2.size.id
  network {
    name = "${data.openstack_networking_network_v2.network.name}"
  }
  availability_zone = var.availability_zone
  key_pair  = data.openstack_compute_keypair_v2.my_keypair.name

  connection {
    type     = "ssh"
    user     = "root"
    private_key = file("~/.ssh/id_ed25519")
    host     = self.access_ip_v4
  }

  provisioner "remote-exec" {
    script = "scripts/wait_for_instance.sh"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.access_ip_v4},' -u root --private-key ~/.ssh/id_ed25519 --extra-vars \"$(terraform output -json)\" ansible/start_httpd.yml"
  }
}
