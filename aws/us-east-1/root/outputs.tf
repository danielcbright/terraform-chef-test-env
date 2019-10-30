output "s3_bucket_name" {
  value = "${aws_s3_bucket.s3-tfstate.id}"
}
output "s3_ssm_bucket_name" {
  value = "${aws_s3_bucket.s3-ssm.id}"
}
output "dynamodb-name-root" {
  value = "${var.dynamo_db_names["dynamodb-name-root"]}"
}
output "dynamodb-name-network" {
  value = "${var.dynamo_db_names["dynamodb-name-network"]}"
}
output "dynamodb-name-compute" {
  value = "${var.dynamo_db_names["dynamodb-name-compute"]}"
}
output "dynamodb-name-security" {
  value = "${var.dynamo_db_names["dynamodb-name-security"]}"
}
output "prefix" {
  value = "${var.prefix}"
}
output "suffix" {
  value = "${var.suffix}"
}
output "default_tags" {
  value = "${var.default_tags}"
}