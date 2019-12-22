output "k8s_cluster_endpoint" {
  value = "${google_container_cluster._.endpoint}"
}

output "app_address" {
  value = "${google_compute_global_address.global.address}"
}
