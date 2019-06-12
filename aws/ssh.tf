resource "aws_key_pair" "personal" {
  key_name   = "${var.prefix}-key"
  public_key = "${var.user-key}"
}
resource "aws_key_pair" "shared_rsa" {
  key_name   = "${var.prefix}-shared-key"
  public_key = "${var.shared-key}"
}
