data "aws_ami" "w2k16" {
  owners      = ["446539779517"]
  most_recent = true

  filter {
    name   = "name"
    values = ["dbright_CA_windows_2016_full*"]
  }
}