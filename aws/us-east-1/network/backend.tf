provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "C:\\Users\\Daniel Bright\\.aws\\credentials"
  profile                 = "Okta_AdministratorAccess"
}
# Must be configured as hard-coded entries AFTER s3/dynamodb setup
terraform {
  backend "s3" {
    bucket         = "dcb-tfstate"
    key            = "us-east-1/network/terraform.tfstate"
    dynamodb_table = "dcb-tflock-us-east-1-network"
    region         = "us-east-1"
  }
}
