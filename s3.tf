resource "aws_s3_bucket" "CHANGEME_test_bucket" {
  bucket = "CHANGEME-test-bucket"
  acl    = "private"

  tags {
    Name        = "CHANGEME S3 Test Bucket"
  }
}
