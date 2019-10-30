data "terraform_remote_state" "root" {
 backend     = "s3"
 config = {
   bucket = "dcb-tfstate"
   key    = "us-east-1/root/terraform.tfstate"
   region = "us-east-1"
 }
}
data "terraform_remote_state" "network" {
 backend     = "s3"

 config = {
   bucket = "dcb-tfstate"
   key    = "us-east-1/network/terraform.tfstate"
   region = "us-east-1"
 }
}
locals {
    s3_ssm            = data.terraform_remote_state.root.outputs.s3_ssm_bucket_name
    prefix            = data.terraform_remote_state.root.outputs.prefix
    suffix            = data.terraform_remote_state.root.outputs.suffix
    vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
    subnet_private_00 = data.terraform_remote_state.network.outputs.subnet_private_00
    subnet_private_01 = data.terraform_remote_state.network.outputs.subnet_private_01
    subnet_public_00  = data.terraform_remote_state.network.outputs.subnet_public_00
    tags              = "${merge(data.terraform_remote_state.root.outputs.default_tags, map(
                          "X-S3-Terraform-Path", "dcb-tfstate::${var.X-S3-Terraform-Path}",
                        ))}"
}