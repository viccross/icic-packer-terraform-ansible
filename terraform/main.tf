data "openstack_images_image_v2" "img" {
  name        = "zrhimg1"
  most_recent = true
}

output "openstack_image_id" {
  description = "The ID of the OpenStack image"
  value       = data.openstack_images_image_v2.img.id
}