variable "project_id" {
  description = "The GCP project id"
  type        = string
}

variable "region" {
  default     = "europe-west2"
  description = "GCP region"
  type        = string
}

variable "service_account" {
  description = "GCP service account"
  type        = string
}


variable "network_name" {
  default     = "appsbrokernetwork"
  type        = string
  description = "Network for the appsBroker assignment"
}

variable "gcp_ip_cidr_range" {
  default     = "10.0.0.0/16"
  type        = string
  description = "IP CIDR Range for Google VPC."
}

variable "subnet_names" {
  type = map(any)

  default = {
    subnet1 = "subnet1"
    subnet2 = "subnet2"
  }
}

# variable "appsb_ssh_user" {
#   default         = "appsbroker"
# }
#
# variable "appsb_ssh_pub_key_file" {
#   source  = "${file("./appsbroker-key.pub")}"
# }
