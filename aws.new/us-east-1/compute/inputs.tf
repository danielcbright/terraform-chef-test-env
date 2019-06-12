data "terraform_remote_state" "static" {
 backend     = "s3"

 config {
   bucket = "db-s3-tfstate"
   key    = "us-east-1/backend/terraform.tfstate"
   region = "us-east-1"
 }
}

data "terraform_remote_state" "network" {
 backend     = "s3"

 config {
   bucket = "db-s3-tfstate"
   key    = "us-east-1/network/terraform.tfstate"
   region = "us-east-1"
 }
}
data "terraform_remote_state" "security" {
 backend     = "s3"

 config {
   bucket = "db-s3-tfstate"
   key    = "us-east-1/security/terraform.tfstate"
   region = "us-east-1"
 }
}

locals {
    prefix            = "${data.terraform_remote_state.static.prefix}"
    suffix            = "${data.terraform_remote_state.static.suffix}"
    vpc_id            = "${data.terraform_remote_state.network.vpc_id}"
    subnet_private_00 = "${data.terraform_remote_state.network.subnet_private_00}"
    subnet_private_01 = "${data.terraform_remote_state.network.subnet_private_01}"
    subnet_public_00  = "${data.terraform_remote_state.network.subnet_public_00}"
    sg_admin          = "${data.terraform_remote_state.security.sg_admin}"
    sg_internal       = "${data.terraform_remote_state.security.sg_internal}"
}