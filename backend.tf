
## GCP BACKEND
terraform {
  # GCP - Google Cloud Storage
  backend "gcs" {
  }
}

provider "google" {
    project     = var.gcp_project.name
    region      = var.gcp_project.region
    credentials = file(var.gcp_project.auth_file)
}

# --------------------------------------------------#

## AWS BACKEND

