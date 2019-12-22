variable "google_project" {}

variable "google_region" {}

variable "cluster_name" {
  default = "general"
}

variable "cluster_node_count" {
  default = 1
}

variable "machine_type" {
  default = "n1-standard-1"
}
