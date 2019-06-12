provider "aws" {
  region     = "us-east-1"
}

//Must be configured as hard-coded entries AFTER s3/dynamodb setup
terraform {
  backend "s3" {
    bucket         = "db-s3-tfstate"
    key            = "us-east-1/backend/terraform.tfstate"
    dynamodb_table = "db-dynamo-tfstate-us-east-1-backend"
    region         = "us-east-1"
  }
}

resource "aws_s3_bucket" "s3-bucket-tfstate" {
  bucket = "${var.s3-bucket-name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = "${merge(var.default_tags, map(
    "Name", "db-tfstate-bucket",
  ))}"
}

resource "aws_dynamodb_table" "dynamodb-tfstate-locking" {
  name           = "${var.dynamodb-name}${var.dynamodb-suffix}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  
  tags = "${merge(var.default_tags, map(
    "Name", "db-tf-locking",
  ))}"
}

