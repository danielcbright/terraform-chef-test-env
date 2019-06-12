output "main-vpc" {
  value = "${aws_vpc.main.id}"
}

output "public-subnet-00" {
  value = "${aws_subnet.public_00.id}"
}

output "private-subnet-00" {
  value = "${aws_subnet.private_00.id}"
}

output "private-subnet-01" {
  value = "${aws_subnet.private_01.id}"
}

output "aws_key_pair" {
  value = "${aws_key_pair.personal.key_name}"
}

output "aws_shared_key_pair" {
  value = "${aws_key_pair.shared_rsa.key_name}"
}

output "aws_security_group_admin" {
  value = "${aws_security_group.admin.id}"
}

output "aws_security_group_internal" {
  value = "${aws_security_group.internal.id}"
}

output "aws_internet_gateway" {
  value = "${aws_internet_gateway.gw.id}"
}
