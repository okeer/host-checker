resource "google_container_cluster" "_" {
  project  = "${var.google_project}"
  name     = "${var.cluster_name}"
  location = "${var.google_region}"

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "_" {
  name     = "${var.cluster_name}-node-pool"
  cluster  = "${google_container_cluster._.name}"
  location = "${var.google_region}"

  node_count = "${var.cluster_node_count}"

  node_config {
    preemptible  = true
    machine_type = "${var.machine_type}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_compute_global_address" "global" {
  name = "global"
}
