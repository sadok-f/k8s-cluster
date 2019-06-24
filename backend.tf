terraform {
  backend "gcs" {
    bucket      = "kiwi-gke-states"
    prefix      = "kiwi"
    credentials = "service-account.json"
  }
}
