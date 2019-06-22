module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google"
  project_id = "${var.project_name}"
  name = "${var.cluster_name}"
  regional = false
  region = "${var.region}"
  zones = "${var.zones}"
  network = "${google_compute_network.k8s-dev.id}"
  subnetwork = "${var.subnetwork_name}"
  ip_range_pods = "${var.ip_range_pods_name}"
  ip_range_services = "${var.ip_range_services_name}"
  service_account = "create"
}

data "google_client_config" "default" {}

resource "google_compute_network" "k8s-dev" {
  name = "k8s-dev"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnetwork" {
  name    = "${var.subnetwork_name}"
  ip_cidr_range = "${var.subnetwork_cidr}"
  network = "${google_compute_network.k8s-dev.id}"
  region = "${var.region}"

  secondary_ip_range {
    range_name    = "${var.ip_range_pods_name}"
    ip_cidr_range = "${var.ip_range_pods}"
  }

  secondary_ip_range {
    range_name    = "${var.ip_range_services_name}"
    ip_cidr_range = "${var.ip_range_services}"
  }
}

