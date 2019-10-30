variable "s3-bucket-name" {
  type             = "string"
  description      = "Name for your s3 bucket that will hold the tfstate keys/files"
  default          = "CHANGEME"
}
variable "s3-ssm-bucket-name" {
  type             = "string"
  description      = "Name for your s3 bucket that will hold the ssm information"
  default          = "CHANGEME"
}


variable "dynamo_db_names" {
  type = "map"
  default = {
    "dynamodb-name-root"     = "PREFIX-tflcok-REGION-root"
    "dynamodb-name-network"  = "PREFIX-tflcok-REGION-network"
    "dynamodb-name-compute"  = "PREFIX-tflcok-REGION-compute"
    "dynamodb-name-security" = "PREFIX-tflcok-REGION-security"
  }
}

#Terraform Tags
variable "default_tags" {
  type = "map"
  default = {
    X-Contact      = "CHANGEME"
    X-Dept         = "CHANGEME"
    X-TF-Path      = "CHANGEME"
  }
}
variable "prefix" {
  type             = "string"
  description      = "Prefix to prepend to downstream consumers of backend vars"
  default          = "CHANGEME"
}
variable "suffix" {
  type             = "string"
  description      = "Suffix to append to downstream consumers of backend vars"
  default          = "CHANGEME"
}
variable "X-S3-Terraform-Path" {
  type             = "string"
  description      = "S3 Bucket + Path for this TFSTATE"
  default          = "CHANGEME"
}