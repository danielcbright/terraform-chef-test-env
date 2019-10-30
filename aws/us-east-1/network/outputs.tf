output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
output "subnet_private_00" {
  value = "${aws_subnet.private_00.id}"
}
output "subnet_private_01" {
  value = "${aws_subnet.private_01.id}"
}
output "subnet_public_00" {
  value = "${aws_subnet.public_00.id}"
}

