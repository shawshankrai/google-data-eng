terraform {
  backend "gcs" {
    bucket = "shashank-iam-terraform-tfstate"
    credentials = "../creds/serviceaccount.json"
  }
}
