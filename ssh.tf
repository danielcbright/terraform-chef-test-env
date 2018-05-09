resource "aws_key_pair" "dbright" {
  key_name   = "CHANGEME-key"
  public_key = "ssh-rsa ##########"
}
resource "aws_key_pair" "shared_rsa" {
  key_name   = "shared_rsa_test_key"
  public_key = "ssh-rsa ##########"
}
