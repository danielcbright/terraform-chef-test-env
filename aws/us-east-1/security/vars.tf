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

variable "allowed_cidrs" {
  type             = "list"
  description      = "A list of allowed CIDRs for SSH"
  default          = ["0.0.0.0/0"]
}

variable "X-S3-Terraform-Path" {
  type             = "string"
  description      = "S3 Bucket + Path for this TFSTATE"
  default          = "CHANGEME"
}
## SSH Keys
variable "ssh_key" {
  type             = "map"
  description      = "EC2 instance SSH key settings"
  default          = {
    file           = "/change/path/to/key"
    name           = "My Super Awesome SSH key"
  }
}
variable "shared_ssh_key" {
  type             = "map"
  description      = "EC2 instance SSH key settings"
  default          = {
    file           = "/change/path/to/key"
    name           = "My Super Awesome Shared SSH key"
  }
}