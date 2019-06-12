# Create a basic Centos 7 Bastion Host to route incoming SSH traffic through
resource "aws_instance" "centos-a" {
  count = 0
  # depends_on = ["aws_instance.chef-server"]
  connection {
    user        = "${var.ssh_username}"
    private_key = "${file("${var.ssh_key["file"]}")}"
  }
  # Provision with Chef
  provisioner "chef" {
     environment             = "${var.chef_environment}"
     node_name               = "centos-7-a-${count.index}"
     use_policyfile          = true
     policy_group            = "dev"
     policy_name             = "dev-role-a"
     server_url              = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
     user_name               = "${var.chef_user["username"]}"
     user_key                = "${file(".chef/user.pem")}"
     version                 = "${var.chef_versions["client"]}"
     fetch_chef_certificates = true
     recreate_client         = true
  }
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.small"
  associate_public_ip_address = true
  subnet_id = "${local.subnet_public_00}"

  key_name = "${aws_key_pair.personal.id}"

  vpc_security_group_ids = ["${local.sg_admin}","${local.sg_internal}"]

  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${local.prefix}centos-7-a-${count.index}",
  ))}"
}

resource "aws_instance" "centos-b" {
  count = 0
  connection {
    user        = "${var.ssh_username}"
    private_key = "${file("${var.ssh_key["file"]}")}"
  }
  # Provision with Chef
  provisioner "chef" {
     environment     = "${var.chef_environment}"
     node_name               = "centos-7-b-${count.index}"
     use_policyfile          = true
     policy_group            = "dev"
     policy_name             = "dev-role-b" 
     server_url              = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
     user_name               = "${var.chef_user["username"]}"
     user_key                = "${file(".chef/user.pem")}"
     version                 = "${var.chef_versions["client"]}"
     fetch_chef_certificates = true
     recreate_client         = true
  }
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.small"
  associate_public_ip_address = true
  subnet_id = "${local.subnet_public_00}"

  key_name = "${aws_key_pair.personal.id}"

  vpc_security_group_ids = ["${local.sg_admin}","${local.sg_internal}"]

  tags = "${merge(data.terraform_remote_state.static.default_tags, map(
    "Name", "${local.prefix}centos-7-b-${count.index}",
  ))}"
}
