terraform {
  backend "gcs" {
    prefix      = "terraform/state"
    credentials = "keyfile.json"
  }
}

provider "google" {
  credentials = "keyfile.json"
  project     = "${var.google_project}"
  region      = "${var.google_region}"
}
