terraform {
  required_version = ">= 1.0"

  backend "s3" {
    dynamodb_table = "terraform-iam-state-locks"
    encrypt        = true
    region         = "eu-west-1"
    bucket         = "terraform-aws-iam-terraform-state-444469924026-eu-west-1"
    key            = "444469924026/eu-west-1/terraform-aws-iam/iam-roles/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}
