module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "0.6.0"
  project_id   = "${var.project_name}"
  network_name = "${var.network_name}"

  subnets = [
    {
      subnet_name   = "${var.subnetwork_name}"
      subnet_ip     = "${var.subnetwork_cidr}"
      subnet_region = "${var.region}"
    },
  ]

  secondary_ranges = {
    "${var.subnetwork_name}" = [
      {
        range_name    = "${var.ip_range_pods_name}"
        ip_cidr_range = "${var.ip_range_pods}"
      },
      {
        range_name    = "${var.ip_range_services_name}"
        ip_cidr_range = "${var.ip_range_services}"
      },
    ]
  }
}

module "gke" {
  source            = "terraform-google-modules/kubernetes-engine/google"
  project_id        = "${var.project_name}"
  name              = "${var.cluster_name}"
  regional          = false
  region            = "${var.region}"
  zones             = "${var.zones}"
  network           = "${module.vpc.network_name}"
  subnetwork        = "${element(module.vpc.subnets_names,1)}"
  ip_range_pods     = "${var.ip_range_pods_name}"
  ip_range_services = "${var.ip_range_services_name}"
  service_account   = "create"
}

data "google_client_config" "default" {}
