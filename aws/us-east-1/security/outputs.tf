output "sg_admin" {
  value = "${aws_security_group.admin.id}"
}
output "sg_internal" {
  value = "${aws_security_group.internal.id}"
}
output "personal-ssh-key-name" {
  value = "${aws_key_pair.personal.id}"
}
output "shared-ssh-key-name" {
  value = "${aws_key_pair.shared.id}"
}