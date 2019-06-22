provider google {
  region = "${var.region}"
  credentials = "${file(var.credentials_path)}"
}

provider "google-beta" {
  version = "~> 2.7.0"
  region = "${var.region}"
  credentials = "${file(var.credentials_path)}"
}
