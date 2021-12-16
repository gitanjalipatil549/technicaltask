resource "google_compute_region_instance_group_manager" "appsbroker" {
  name               = "appsbroker-${var.region}"
  base_instance_name = "appsbroker-${var.region}"
  region             = var.region
  target_size        = "1"

  version {
    instance_template = google_compute_instance_template.appsbroker.id
  }

}

resource "google_compute_instance_template" "appsbroker" {
  description          = "the appsbroker backend application."
  tags                 = ["appsbroker"]
  instance_description = "appsbroker backend"
  machine_type         = "g1-small"
  can_ip_forward       = false

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y nginx; sudo systemctl start nginx"

  metadata = {
    ssh-keys = "appsbroker:${file("./appsbroker-key.pub")}"
  }


  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }

  disk {
    source_image = data.google_compute_image.my_image.self_link
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = ""
    }
  }


}




resource "google_compute_health_check" "appsbroker" {
  name                = "appsbroker-${var.region}"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "8080"
  }
}

data "google_compute_image" "my_image" {
  family  = "debian-9"
  project = "debian-cloud"
}
