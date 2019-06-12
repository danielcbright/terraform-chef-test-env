variable "s3-bucket-name" {
  type             = "string"
  description      = "Name for your s3 bucket that will hold the tfstate keys/files"
  default          = "CHANGEME"
}

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

## Prefix/Tagging Variables
variable "prefix" {
  default = "CHANGEME-"
}
variable "suffix" {
  default = "CHANGEME"
}
variable "default_tags" {
  type = "map"
  default = {
    X-Contact      = "CHANGEME"
    X-Dept         = "CHANGEME"
  }
}