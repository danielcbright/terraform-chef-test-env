output "sg_admin" {
  value = "${aws_security_group.admin.id}"
}
output "sg_internal" {
  value = "${aws_security_group.internal.id}"
}