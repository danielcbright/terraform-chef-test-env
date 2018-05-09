# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
resource "aws_instance" "linux-bastion" {
  # depends_on = ["aws_instance.chef-server"]
  connection {
    host        = "${aws_instance.chef-server.public_ip}"
    user        = "${var.ssh_username}"
    private_key = "${file("${var.ssh_key["file"]}")}"
  }
  # Provision with Chef
  # provisioner "chef" {
  #   environment     = "_default"
  #   node_name       = "linux-bastion-us-east-1"
  #   run_list        = ["recipe[bastion-host::default]"]
  #   server_url      = "https://dbright.chef.io/organizations/${var.chef_org["short"]}"
  #   user_name       = "${var.chef_user["username"]}"
  #   user_key        = "${file(".chef/user.pem")}"
  #   fetch_chef_certificates = true
  # }
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = "${aws_subnet.chef_01_public.id}"

  key_name = "${aws_key_pair.dbright.id}"

  vpc_security_group_ids = ["${aws_security_group.chef_admin.id}","${aws_security_group.chef_internal.id}"]

  tags = "${merge(var.default_tags, map(
    "Name", "${var.prefix}-linux-bastion",
  ))}"
}
