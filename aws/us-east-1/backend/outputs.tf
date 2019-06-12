output "s3_bucket_name" {
  value = "${aws_s3_bucket.s3-bucket-tfstate.id}"
}
output "dynamo_db_name" {
  value = "${aws_dynamodb_table.dynamodb-tfstate-locking.id}"
}
output "tfstate_key" {
  value = "${var.tfstate-key}/terraform.tfstate"
}
output "default_tags" {
  value = "${var.default_tags}"
}
output "prefix" {
  value = "${var.prefix}"
}
output "suffix" {
  value = "${var.suffix}"
}