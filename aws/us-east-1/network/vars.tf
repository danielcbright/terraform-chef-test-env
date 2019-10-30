variable "dynamodb-name" {
  type             = "string"
  description      = "Name for your dynamodb db that will be used for Terraform locking"
  default          = "CHANGEME"
}

variable "tfstate-key" {
  type             = "string"
  description      = "keypath to the tfstate file in the s3 bucket, should match dir structure"
  default          = "CHANGE/ME"
}

## Network Settings

variable "networking" {
  type = "map"
  description = "Network info for the VPC and it's subnets"
  default = {
    main_vpc_cidr_block        = "10.12.23.0/24"
    public_00_cidr_block       = "10.12.23.0/27" #30 useable IPs
    private_00_cidr_block      = "10.12.23.32/28" #14 useable IPs
    private_01_cidr_block      = "10.12.23.48/28" #14 useable IPs
  }
}
variable "X-S3-Terraform-Path" {
  type             = "string"
  description      = "S3 Bucket + Path for this TFSTATE"
  default          = "CHANGEME"
}