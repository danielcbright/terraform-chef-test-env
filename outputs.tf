output "chef-vpc" {
  value = "${aws_vpc.chef.id}"
}

output "chef-subnet-01" {
  value = "${aws_subnet.chef_01_public.id}"
}

output "chef-subnet-02" {
  value = "${aws_subnet.chef_02_private.id}"
}

output "chef-subnet-03" {
  value = "${aws_subnet.chef_03_private.id}"
}

output "aws_key_pair" {
  value = "${aws_key_pair.CHANGEME.key_name}"
}

output "aws_security_group_admin" {
  value = "${aws_security_group.chef_admin.id}"
}

output "aws_security_group_internal" {
  value = "${aws_security_group.chef_internal.id}"
}

output "s3_bucket" {
  value = "${aws_s3_bucket.CHANGEME_test_bucket.id}"
}

output "aws_internet_gateway" {
  value = "${aws_internet_gateway.chef_gw.id}"
}
