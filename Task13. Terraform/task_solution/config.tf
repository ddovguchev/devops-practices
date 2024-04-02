provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "tfstate-playsdev-treinee"
    key    = "AWS/dev/terraform.tfstate"
    region = "eu-central-1"
  }
}