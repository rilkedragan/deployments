terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
        version = "~> 4.0"
    }
  }
}

  provider "google" {
  region      = "us-central1"
  project     = "radiant-land-387911"
  credentials = file("radiant-land-387911-e88d189355e6.json")

}
