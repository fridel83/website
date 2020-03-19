terraform {
  backend "s3" {
    bucket = "custom-project"
    key    = "terraform/network"
    region = "eu-west-3"
  }
}