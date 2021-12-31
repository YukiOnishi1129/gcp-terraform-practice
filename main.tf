terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.72.0"
    }
  }
}

provider "google" {
  credentials = file("keyのフルパス")

  project = "yuki-gcp-practice"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}