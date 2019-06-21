variable region {
  default = "europe-west3"
}

variable zones {
  type = "list"
  default = [
    "europe-west3-c"
  ]
}

provider google {
  region = "${var.region}"
  credentials = "${file(var.credentials_path)}"
}

provider "google-beta" {
  version = "~> 2.7.0"
  region = "${var.region}"
  credentials = "${file(var.credentials_path)}"
}

variable credentials_path {
  default = "k8s-tuto-service.json"
}

variable num_nodes {
  default = 3
}

variable cluster_name {
  default = "dev"
}

variable k8s_version {
  default = "1.14.0"
}

variable project_name {
  default = "k8s-tuto"
}

variable subnetwork_name {
  default = "k8s-subnetwork"
}

variable ip_range_pods {
  default = "192.168.10.0/24"
}

variable ip_range_pods_name {
  default = "pods-subnetwork"
}

variable ip_range_services {
  default = "10.0.32.0/20"
}

variable ip_range_services_name {
  default = "services-subnetwork"
}

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
  ip_cidr_range = "10.2.0.0/16"
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

