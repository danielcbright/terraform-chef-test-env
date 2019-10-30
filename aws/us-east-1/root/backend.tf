# //Must be configured as hard-coded entries AFTER s3/dynamodb setup
terraform {
  backend "s3" {
    bucket         = "dcb-tfstate"
    key            = "us-east-1/root/terraform.tfstate"
    dynamodb_table = "dcb-tflock-us-east-1-root"
    region         = "us-east-1"
  }
}
