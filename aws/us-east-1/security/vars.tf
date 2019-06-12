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
  type             = "string"
  description      = "A list of allowed CIDRs for SSH"
  default          = "0.0.0.0/0"
}