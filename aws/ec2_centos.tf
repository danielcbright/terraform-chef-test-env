# # Create a basic Centos 7 Bastion Host to route incoming SSH traffic through
# resource "aws_instance" "centos-b" {
#   count = 2
#   # depends_on = ["aws_instance.chef-server"]
#   connection {
#     user        = "${var.ssh_username}"
#     private_key = "${file("${var.ssh_key["file"]}")}"
#   }
#   # Provision with Chef
#   provisioner "chef" {
#      environment     = "dbright-dev"
#      node_name       = "centos-7-b-${count.index}"
#      run_list        = ["recipe[eg-linux-role-b::default]"]
#      server_url      = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
#      user_name       = "${var.chef_user["username"]}"
#      user_key        = "${file(".chef/user.pem")}"
#      version          = "${var.chef_versions["client"]}"
#      fetch_chef_certificates = true
#      recreate_client=true
#   }
#   ami           = "${data.aws_ami.centos.id}"
#   instance_type = "t2.small"
#   associate_public_ip_address = true
#   subnet_id = "${aws_subnet.public_00.id}"

#   key_name = "${aws_key_pair.personal.id}"

#   vpc_security_group_ids = ["${aws_security_group.admin.id}","${aws_security_group.internal.id}"]

#   tags = "${merge(var.default_tags, map(
#     "Name", "${var.prefix}-centos-7-b-${count.index}",
#   ))}"
# }

# resource "aws_instance" "centos-g" {
#   count = 2
#   # depends_on = ["aws_instance.chef-server"]
#   connection {
#     user        = "${var.ssh_username}"
#     private_key = "${file("${var.ssh_key["file"]}")}"
#   }
#   # Provision with Chef
#   provisioner "chef" {
#      environment     = "dbright-dev"
#      node_name       = "centos-7-g-${count.index}"
#      run_list        = ["recipe[eg-linux-role-g::default]"]
#      server_url      = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
#      user_name       = "${var.chef_user["username"]}"
#      user_key        = "${file(".chef/user.pem")}"
#      version         = "${var.chef_versions["client"]}"
#      fetch_chef_certificates = true
#      recreate_client=true
#   }
#   ami           = "${data.aws_ami.centos.id}"
#   instance_type = "t2.small"
#   associate_public_ip_address = true
#   subnet_id = "${aws_subnet.public_00.id}"

#   key_name = "${aws_key_pair.personal.id}"

#   vpc_security_group_ids = ["${aws_security_group.admin.id}","${aws_security_group.internal.id}"]

#   tags = "${merge(var.default_tags, map(
#     "Name", "${var.prefix}-centos-7-g-${count.index}",
#   ))}"
# }
