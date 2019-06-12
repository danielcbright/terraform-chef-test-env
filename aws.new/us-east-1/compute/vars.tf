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

## Chef Settings
variable "chef_environment" {
  type             = "string"
  description      = "Chef environment to use"
  default          = "CHANGEME"
}
variable "chef_org" {
  type             = "map"
  description      = "Chef organization settings"
  default          = {
    long           = "Chef Organization"
    short          = "chef"
  }
}
variable "chef_user" {
  type                            = "map"
  description                     = "Chef user settings"
  default                         = {
    email                         = "CHANGEME@domain.tld"
    first                         = "CHANGEME"
    last                          = "CHANGEME"
    username                      = "CHANGEME"
  }
}
variable "chef_versions" {
  type             = "map"
  description      = "EC2 instance SSH key settings"
  default          = {
           client  = "UPDATEME"
           server  = "UPDATEME"
  }
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
variable "user-key" {
  type             = "string"
  description      = "Your local user SSH key for connecting to nodes"
  default          = "CHANGEME"
}

variable "shared-key" {
  type             = "string"
  description      = "Your shared SSH key for nodes to connect to other nodes"
  default          = "CHANGEME"
}
variable "ssh_username" {
  type                            = "string"
  description                     = "Username for instance SSH use"
  default                         = "centos"
}
# Windows Settings
variable "windows_user" {
  type                            = "map"
  description                     = "Windows WinRM/RDP Username/PW"
  default                         = {
    username                      = "Administrator"
    password                      = "CHANGEME"
  }
}