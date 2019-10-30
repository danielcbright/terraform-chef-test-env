data "terraform_remote_state" "root" {
 backend  = "s3"
 config = {
   bucket = "dcb-tfstate"
   key    = "us-east-1/root/terraform.tfstate"
   region = "us-east-1"
 }
}
data "terraform_remote_state" "network" {
 backend  = "s3"

 config = {
   bucket = "dcb-tfstate"
   key    = "us-east-1/network/terraform.tfstate"
   region = "us-east-1"
 }
}
data "terraform_remote_state" "security" {
 backend  = "s3"

 config = {
   bucket = "dcb-tfstate"
   key    = "us-east-1/security/terraform.tfstate"
   region = "us-east-1"
 }
}

locals {
    prefix            = data.terraform_remote_state.root.outputs.prefix
    suffix            = data.terraform_remote_state.root.outputs.suffix
    vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
    subnet_private_00 = data.terraform_remote_state.network.outputs.subnet_private_00
    subnet_private_01 = data.terraform_remote_state.network.outputs.subnet_private_01
    subnet_public_00  = data.terraform_remote_state.network.outputs.subnet_public_00
    sg_admin          = data.terraform_remote_state.security.outputs.sg_admin
    sg_internal       = data.terraform_remote_state.security.outputs.sg_internal
    personal-ssh      = data.terraform_remote_state.security.outputs.personal-ssh-key-name
    shared-ssh        = data.terraform_remote_state.security.outputs.shared-ssh-key-name
    tags              = "${merge(data.terraform_remote_state.root.outputs.default_tags, map(
                          "X-S3-Terraform-Path", "dcb-tfstate::${var.X-S3-Terraform-Path}",
                        ))}"
    sql_priv_ips      = "--peer ${join(" --peer ", var.sql_private_ips)}"
    frontend_priv_ips = "--peer ${join(" --peer ", var.frontend_private_ips)}"
}