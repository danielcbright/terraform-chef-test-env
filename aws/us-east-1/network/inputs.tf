data "terraform_remote_state" "root" {
 backend     = "s3"
 config = {
   bucket = "dcb-tfstate"
   key    = "us-east-1/root/terraform.tfstate"
   region = "us-east-1"
 }
}
locals {
    prefix            = data.terraform_remote_state.root.outputs.prefix
    suffix            = data.terraform_remote_state.root.outputs.suffix
    tags              = "${merge(data.terraform_remote_state.root.outputs.default_tags, map(
                          "X-S3-Terraform-Path", "dcb-tfstate::${var.X-S3-Terraform-Path}",
                        ))}"
}