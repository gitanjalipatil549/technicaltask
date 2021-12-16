terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.4.0"
    }
  }
}

provider "google" {
  credentials = file("access-key.json")
  project     = var.project_id
  region      = var.region
}
