terraform {
  required_version = ">= 1.7.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  backend "s3" {
    bucket         = "husain-terraform-state-ddrivers-2024"
    key            = "development/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf_lock_table_dev"
  }
}

provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      managed_by = "GH_Terraform"
    }
  }
}
