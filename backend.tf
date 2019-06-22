terraform {
  backend "gcs" {
    bucket = "kiwi-k8s-states"
    prefix = "kiwi"
    credentials = "service-account.json"
  }
}