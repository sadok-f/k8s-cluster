variable region {
  default = "europe-west3"
}

variable zones {
  type = "list"

  default = [
    "europe-west3-c",
  ]
}

variable credentials_path {
  default = "service-account.json"
}

variable num_nodes {
  default = 3
}

variable cluster_name {
  default = "kiwi-dev"
}

variable k8s_version {
  default = "1.14.0"
}

variable project_name {
  default = "kiwi-k8s-244506"
}

variable network_name {
  default = "kiwi-vpc"
}

variable subnetwork_name {
  default = "k8s-subnetwork"
}

variable subnetwork_cidr {
  default = "10.0.0.0/24"
}

variable ip_range_pods {
  default = "192.168.10.0/24"
}

variable ip_range_pods_name {
  default = "pods-subnetwork"
}

variable ip_range_services {
  default = "192.168.20.0/24"
}

variable ip_range_services_name {
  default = "services-subnetwork"
}
