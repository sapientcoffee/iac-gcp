resource "google_compute_network" "tf-virt-net" {
  name = "${var.prefix}-virt-net"
  auto_create_subnetworks = false
  mtu                     = 1460
}

// Espresso Subnet
resource "google_compute_subnetwork" "subnet-espresso" {
  name          = "${var.prefix}-espresso"
  region        = "${var.region}"
  ip_cidr_range = "192.168.101.0/26"
  network       = "${google_compute_network.tf-virt-net.self_link}"
}

// Flat White Subnet
resource "google_compute_subnetwork" "flat-white" {
  name          = "${var.prefix}-flat-white"
  region        = "${var.region}"
  ip_cidr_range = "192.168.16.0/22"
  network       = "${google_compute_network.tf-virt-net.self_link}"
}


# # This queries GCP for the latest Kubernetes engine version.
# data "google_container_engine_versions" "versions" {
#   location = var.region
# }

# # This creates a new Google Kubernetes Engine (GKE) cluster inside our project.
# # This operation can take a few minutes to complete, but Terraform will show
# # output and updates as the creation progresses.
# resource "google_container_cluster" "iac-cluster" {
#   name     = "iac-cluster"
#   location = var.region

#   initial_node_count = 1

#   min_master_version = data.google_container_engine_versions.versions.latest_master_version
#   node_version       = data.google_container_engine_versions.versions.latest_node_version

#   node_config {
#     machine_type = var.instance_type
#   }
# }

# # Make a change without PR
# #
# # resource "google_compute_address" "default" {
# #   name   = "my-address"
# #   region = var.region
# # }

# # PR change
# # resource "google_compute_address" "pr-address" {
# #   name   = "pr-address"
# #   region = var.region
# # }
