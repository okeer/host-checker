terraform {
  backend "s3" {
    bucket  = "okeer-eks-state"
    key     = "terraform/vpc.tfstate"
    region  = "eu-central-1"
    profile = "sorlov"
  }

  required_version = "~> 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "sorlov"
  region  = "eu-central-1"
}
