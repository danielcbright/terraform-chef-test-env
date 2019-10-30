# Linux Settings
variable "linux" {
  type                            = "string"
  description                     = "Username for instance SSH use"
  default                         = "centos"
}
# # Windows Settings
# variable "windows" {
#   type                            = "map"
#   description                     = "Windows WinRM/RDP Username/PW"
#   default                         = {
#     username                      = "Administrator"
#     password                      = "CHANGEME"
#   }
# }
variable "ssh_key" {
  type             = "map"
  description      = "EC2 instance SSH key settings"
  default          = {
    file           = "/change/path/to/key"
    name           = "My Super Awesome SSH key"
  }
}
variable "X-S3-Terraform-Path" {
  type             = "string"
  description      = "S3 Bucket + Path for this TFSTATE"
  default          = "CHANGEME"
}
variable "automate_token" {
  type             = "string"
  description      = "Automate Token for sending Effortless data"
  default          = "CHANGEME"
}
variable "automate_url" {
  type             = "string"
  description      = "Automate URL"
  default          = "CHANGEME"
}
variable "automate_url_trn" {
  type             = "string"
  description      = "Automate URL truncated for Audit config"
  default          = "CHANGEME"
}

variable "sql_private_ips" {
  type             = "list"
  description      = "Private IP List for SQL Server(s)"
  default          = ["CHANGEME"]
}

variable "frontend_private_ips" {
  type             = "list"
  description      = "Private IP List for Frontend Nodes"
  default          = ["CHANGEME"]
}
variable "hab_token" {
  type             = "string"
  description      = "Hab Token for private depot access"
  default          = "CHANGEME"
}