data "terraform_remote_state" "static" {
 backend     = "s3"

 config {
   bucket = "db-s3-tfstate"
   key    = "us-east-1/backend/terraform.tfstate"
   region = "us-east-1"
 }
}