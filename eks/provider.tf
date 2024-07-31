terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
 backend "s3"{
  bucket  = "my-eks-terraform-test"
  key = "terraform.tfstate"
  region = "us-west-1"
}
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}
