provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "C:\\Users\\Daniel Bright\\.aws\\credentials"
  profile                 = "Okta_AdministratorAccess"
}

locals {
  tags = "${merge(var.default_tags, map(
    "X-S3-Terraform-Path", "${var.s3-bucket-name}::${var.X-S3-Terraform-Path}",
  ))}"
}

resource "aws_s3_bucket" "s3-tfstate" {
  bucket = "${var.s3-bucket-name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = "${merge(local.tags, map(
    "Name", "${var.s3-bucket-name}",
  ))}"
}
resource "aws_s3_bucket" "s3-ssm" {
  bucket = "${var.s3-ssm-bucket-name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = "${merge(local.tags, map(
    "Name", "${var.s3-ssm-bucket-name}",
  ))}"
}

resource "aws_dynamodb_table" "tfstate-locking-root" {
  name           = var.dynamo_db_names.dynamodb-name-root
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${merge(local.tags, map(
    "Name", "${var.dynamo_db_names.dynamodb-name-root}",
  ))}"
}

resource "aws_dynamodb_table" "tfstate-locking-network" {
  name           = var.dynamo_db_names.dynamodb-name-network
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${merge(local.tags, map(
    "Name", "${var.dynamo_db_names.dynamodb-name-network}",
  ))}"
}

resource "aws_dynamodb_table" "tfstate-locking-compute" {
  name           = var.dynamo_db_names.dynamodb-name-compute
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${merge(local.tags, map(
    "Name", "${var.dynamo_db_names.dynamodb-name-compute}",
  ))}"
}

resource "aws_dynamodb_table" "tfstate-locking-security" {
  name           = var.dynamo_db_names.dynamodb-name-security
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${merge(local.tags, map(
    "Name", "${var.dynamo_db_names.dynamodb-name-security}",
  ))}"
}