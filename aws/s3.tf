resource "aws_s3_bucket" "dbright-tfstate-bucket" {
  bucket = "dbright-tfstate-bucket"
  acl    = "private"

  tags {
    Name        = "DBright S3 Test Bucket"
  }
}
