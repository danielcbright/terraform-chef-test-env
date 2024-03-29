provider "aws" {
  region     = "us-east-1"
}
data "terraform_remote_state" "static" {
 backend     = "s3"

 config {
   bucket = "db-s3-tfstate"
   key    = "us-east-1/backend/terraform.tfstate"
   region = "us-east-1"
 }
}

# Must be configured as hard-coded entries AFTER s3/dynamodb setup
terraform {
  backend "s3" {
    bucket         = "db-s3-tfstate"
    key            = "us-east-1/CHANGEME/terraform.tfstate"
    dynamodb_table = "db-dynamo-tfstate-us-east-1-changeme"
    region         = "us-east-1"
  }
}

resource "aws_dynamodb_table" "dynamodb-tfstate-locking" {
  name           = "${var.dynamodb-name}${var.dynamodb-suffix}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  
  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "db-tf-locking-changeme",
  ))}"
}