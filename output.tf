output "instance_group_manager" {
  value = google_compute_region_instance_group_manager.appsbroker.instance_group
}

output "health_check" {
  value = google_compute_health_check.appsbroker.self_link
}
