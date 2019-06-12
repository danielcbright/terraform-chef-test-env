resource "aws_key_pair" "personal" {
  key_name   = "${local.prefix}key-00"
  public_key = "${var.user-key}"
}
resource "aws_key_pair" "shared_rsa" {
  key_name   = "${local.prefix}shared-key-00"
  public_key = "${var.shared-key}"
}