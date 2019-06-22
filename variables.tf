variable region {
  default = "europe-west3"
}

variable zones {
  type = "list"
  default = [
    "europe-west3-c"
  ]
}

variable credentials_path {
  default = "service-account.json"
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

variable subnetwork_cidr {
  default = "192.168.0.0/24"
}

variable ip_range_pods {
  default = "10.0.0.0/24"
}

variable ip_range_pods_name {
  default = "pods-subnetwork"
}

variable ip_range_services {
  default = "10.1.0.0/24"
}

variable ip_range_services_name {
  default = "services-subnetwork"
}