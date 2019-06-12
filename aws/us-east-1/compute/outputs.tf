
# Show the public IP address at the end
output "windows-a-address" {
  value = "${aws_instance.windows-a.*.public_ip}"
}
output "windows-b-address" {
  value = "${aws_instance.windows-b.*.public_ip}"
}