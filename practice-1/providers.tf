locals {
    terraform_service_account = "terraform-gcp-acount@terraform-sample-429205.iam.gserviceaccount.com"
}

terraform {
    required_version = ">= 1.7"
    required_providers {
      google = {
        version = "~> 5.0"
      }
    }
}

provider "google" {
    alias = "impersonation"
    scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/userinfo.email"
    ]
    project = "terraform-sample-429205"
    region = "asia-south1"
}

data "google_service_account_access_token" "default" {
    provider = google.impersonation
    target_service_account = local.terraform_service_account
    scopes = [ "userinfo-email", "cloud-platform"]
    lifetime = "1200s"
}

provider "google" {
    project = "terraform-sample-429205"
    region = "asia-south1"
    access_token = data.google_service_account_access_token.default.access_token
    request_timeout = "60s"
}