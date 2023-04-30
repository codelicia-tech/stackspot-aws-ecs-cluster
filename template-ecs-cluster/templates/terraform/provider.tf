provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-{{org_name}}-prod"
    key    = "terraform-state.tfstate"
    region = "us-east-1"
  }
}

