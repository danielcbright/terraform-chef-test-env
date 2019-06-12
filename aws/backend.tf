terraform {
  backend "s3" {
    bucket = "dbright-tfstate-bucket"
    key    = "aws/terraform.tfstate"
    region = "us-east-1"
  }
}