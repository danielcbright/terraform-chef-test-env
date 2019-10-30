# Create a basic Centos 7 Bastion Host to route incoming SSH traffic through
resource "aws_instance" "cache" {
  count = 1
  connection {
    host        = self.public_ip
    user        = "centos"
    private_key = "${file("${var.ssh_key["file"]}")}"
  }
  # Provision with Chef
  provisioner "chef" {
     node_name               = "cache-${count.index}"
     use_policyfile          = true
     policy_group            = "dev"
     policy_name             = "lin-web-app-stack"
     server_url              = "https://chef-server.dbright.io:4443/organizations/dbright"
     user_name               = "dbright"
     user_key                = "${file(".chef/user.pem")}"
     version                 = "15.4.45"
     client_options          = ["chef_license 'accept'", "named_run_list 'cache'"]
     fetch_chef_certificates = true
     recreate_client         = true
  }

  provisioner "habitat" {
    peers              = [self.private_ip]
    use_sudo           = true
    service_type       = "systemd"
    accept_license     = true
    auto_update        = true
    builder_auth_token = "${var.hab_token}"

    service {
      name        = "dbright/lin-effortless-audit"
      topology    = "standalone"
      user_toml   = file("files/lin-effortless-audit-user.toml")
      channel     = "stable"
      group       = "dev"
      application = "Linux Effortless Baseline"
      strategy    = "at-once"
    }
  }

  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.small"
  associate_public_ip_address = true
  subnet_id = "${local.subnet_public_00}"

  key_name = local.personal-ssh

  vpc_security_group_ids = [local.sg_admin,local.sg_internal]

  tags  = "${merge(local.tags, map(
          "Name", "${local.prefix}cache-${count.index}${local.suffix}",
          ))}"
}

resource "aws_instance" "web" {
  count = 1
  connection {
    host        = self.public_ip
    user        = "centos"
    private_key = "${file("${var.ssh_key["file"]}")}"
  }
  # Provision with Chef
  provisioner "chef" {
     node_name               = "web-${count.index}"
     use_policyfile          = true
     policy_group            = "dev"
     policy_name             = "lin-web-app-stack"
     server_url              = "https://chef-server.dbright.io:4443/organizations/dbright"
     user_name               = "dbright"
     user_key                = "${file(".chef/user.pem")}"
     version                 = "15.4.45"
     client_options          = ["chef_license 'accept'", "named_run_list 'web'"]
     fetch_chef_certificates = true
     recreate_client         = true
  }

  provisioner "habitat" {
    peers              = [self.private_ip]
    use_sudo           = true
    service_type       = "systemd"
    accept_license     = true
    auto_update        = true
    builder_auth_token = "${var.hab_token}"

    service {
      name        = "dbright/lin-effortless-audit"
      topology    = "standalone"
      user_toml   = file("files/lin-effortless-audit-user.toml")
      channel     = "stable"
      group       = "dev"
      application = "Linux Effortless Baseline"
      strategy    = "at-once"
    }
  }

  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.small"
  associate_public_ip_address = true
  subnet_id = "${local.subnet_public_00}"

  key_name = local.personal-ssh

  vpc_security_group_ids = [local.sg_admin,local.sg_internal]

  tags  = "${merge(local.tags, map(
          "Name", "${local.prefix}web-${count.index}${local.suffix}",
          ))}"
}