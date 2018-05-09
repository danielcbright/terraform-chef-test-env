variable "aws" {
  type = "map"
  description = "AWS specific settings"
  default = {
    access_key                      = "CHANGEME"
    secret_key                      = "CHANGEME"
    region                          = "us-east-1"
  }
}
## General Variables
variable "prefix" {
  default = "CHANGEME-"
}
variable "default_tags" {
  type = "map"
  default = {
    X-Contact                     = "CHANGEME"
    X-Dept                        = "CHANGEME"
  }
}

## Chef Certs/Files/Secrets
variable "ssl_cert_arn" {
  type                            = "string"
  description                     = "SSL Cert ARN - this must be done using the AWS Console"
  default                         = ""
}
variable "automate_token" {
  type                            = "string"
  description                     = "Automate token that Chef will use to communicate with Automate, this is the out of the box default, change for added security"
  default                         = "93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506"
}
variable "chef_ssl" {
  type                            = "map"
  description                     = "Chef server SSL; paths to the server cert and pem private key files"
  default                         = {
    cert                          = "/change/me/to/file.crt"
    key                           = "/change/me/to/file.pem"
  }
}
variable "chef_automate_license" {
  default                         = "string"
  description                     = "Local path of your automate license file"
  default                         = ".chef/delivery.license"
}
variable "chef_user" {
  type                            = "map"
  description                     = "Chef user settings"
  default                         = {
    email                         = "chef.admin@domain.tld"
    first                         = "Chef"
    last                          = "Admin"
    username                      = "chefadmin"
  }
}
variable "ssh_username" {
  type                            = "string"
  description                     = "Username for instance SSH use"
  default                         = "centos"
}

# Windows Bastion Host
variable "windows_bastion_user" {
  type                            = "map"
  description                     = "Windows WinRM/RDP Username/PW"
  default                         = {
    username                      = "Administrator"
    password                      = "CHANGEME"
  }
}

## Network Settings
variable "allowed_cidrs" {
  type             = "string"
  description      = "A list of allowed CIDRs for SSH"
  default          = "0.0.0.0/0"
}
variable "chef_networking" {
  type = "map"
  description = "Network info for Chef VPC and it's subnets"
  default = {
    main_vpc_cidr_block             = "10.12.12.0/24" #254 useable IPs
    chef_01_public_cidr_block       = "10.12.12.0/27" #30 useable IPs
    chef_02_private_cidr_block      = "10.12.12.32/28" #14 useable IPs
    chef_03_private_cidr_block      = "10.12.12.48/28" #14 useable IPs
  }
}

## Chef Server Settings
variable "chef_addons" {
  type             = "string"
  description      = "Comma seperated list of Chef addons to install"
  default          = "manage,push-jobs-server"
}
variable "chef_license" {
  type             = "string"
  description      = "Acceptance of the Chef MLSA: https://www.chef.io/online-master-agreement/"
  default          = "false"
}
variable "chef_log" {
  #type             = "boolean"
  description      = "Log chef provisioner to file"
  default          = "true"
}
variable "chef_org" {
  type             = "map"
  description      = "Chef organization settings"
  default          = {
    long           = "Chef Organization"
    short          = "chef"
  }
}
variable "instance" {
  type             = "map"
  description      = "EC2 instance host settings"
  default          = {
    domain         = "localdomain"
    hostname       = "localhost"
  }
}
variable "instance_type" {
  type             = "string"
  description      = "EC2 instance flavor (type). Default: c3.xlarge"
  default          = "c3.xlarge"
}
variable "instance_volume" {
  type             = "map"
  description      = "EC2 instance root volume settings"
  default          = {
    delete         = "true"
    size           = 20
    type           = "gp2"
  }
}
variable "ssh_key" {
  type             = "map"
  description      = "EC2 instance SSH key settings"
  default          = {
    file           = ""
    name           = ""
  }
}
variable "shared_ssh_key" {
  type             = "map"
  description      = "EC2 instance SSH key settings"
  default          = {
    file           = ""
    name           = ""
  }
}
variable "chef_server_pub" {
  #type             = "boolean"
  description      = "Associate a public IP to the Chef Server instance"
  default          = "true"
}
variable "automate_server_pub" {
  #type             = "boolean"
  description      = "Associate a public IP to the Chef Server instance"
  default          = "true"
}
variable "admin_password" {
  default = "super-secret-password"
}
variable "automate_rpm_link" {
  type             = "string"
  description      = "Chef Automate RPM download link"
  default          = "https://packages.chef.io/files/stable/automate/1.8.3/el/7/automate-1.8.3-1.el7.x86_64.rpm"
}

# Windows Bastion Host
variable "win_ami" {
  type = "string"
  description = "AMI ID to use for Windows Server 2012R2 bastion host"
  default = "ami-30540427" #us-east-1 WS2K12R2 AMI
}
