resource "aws_key_pair" "personal" {
  key_name   = "${var.ssh_key.name}"
  public_key = file(var.ssh_key.file)
}
resource "aws_key_pair" "shared" {
  key_name   = "${var.shared_ssh_key.name}"
  public_key = file(var.shared_ssh_key.file)
}