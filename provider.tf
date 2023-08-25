terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.59.0"
    }
  }
}

data "google_service_account_access_token" "default" {
 provider               	= google.impersonation
 target_service_account 	= local.terraform_service_account
 scopes                 	= ["userinfo-email", "cloud-platform"]
 lifetime               	= "1200s"
}

provider "google" {
 alias = "impersonation"
 scopes = [
   "https://www.googleapis.com/auth/cloud-platform",
   "https://www.googleapis.com/auth/userinfo.email",
 ]
}

provider "google" {
 project = "terraform-gcp-382215"
 region = "us-central1"
 zone = "us-central1-a"
 access_token	= data.google_service_account_access_token.default.access_token
 request_timeout 	= "60s"
}

locals {
 terraform_service_account = "terraform-gcp@terraform-gcp-382215.iam.gserviceaccount.com"
}

