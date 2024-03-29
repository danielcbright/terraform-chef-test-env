variable "dynamodb-name" {
  type             = "string"
  description      = "Name for your dynamodb db that will be used for Terraform locking"
  default          = "CHANGEME"
}

variable "dynamodb-suffix" {
  type             = "string"
  description      = "Ending for dynamodb db name, this should match the dir structure, but with - instead of /"
  default          = "CHANGE-ME"
}

variable "tfstate-key" {
  type             = "string"
  description      = "keypath to the tfstate file in the s3 bucket, should match dir structure"
  default          = "CHANGE/ME"
}