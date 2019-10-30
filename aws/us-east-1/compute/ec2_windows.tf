resource "aws_instance" "windows-sql" {
  count = 0
  tags  = "${merge(local.tags, map(
          "Name", "${local.prefix}windows-frontend-${count.index}${local.suffix}",
          ))}"
  iam_instance_profile        = "dcb_ssm_instance_profile"
  subnet_id                   = "${local.subnet_public_00}"
  associate_public_ip_address = true
  private_ip                  = "${var.sql_private_ips[count.index]}"
  instance_type               = "t2.medium"
  ami                         = "${data.aws_ami.w2k16.id}"
  key_name                    = local.personal-ssh
  vpc_security_group_ids      = [local.sg_admin,local.sg_internal]
  get_password_data           = true
  user_data                   = templatefile("./files/user_data_sql.tpl", {
                                  peers = "${local.sql_priv_ips}"
                                  automate_token = "${var.automate_token}"
                                  automate_url = "${var.automate_url}"
                                  automate_url_trn = "${var.automate_url_trn}"
                                  hab_token = "${var.hab_token}"
                                  node_name = "${local.prefix}windows-sql-${count.index}${local.suffix}"
                                  debug = "false"
                                })
  #user_data                   = "${data.template_file.user_data_sql.rendered}"
  connection {
    type      = "winrm"
    password  = "${rsadecrypt(self.password_data, file(var.ssh_key.file))}"
    agent     = "false"
    insecure  = true
    https     = false
    host      = self.public_ip
  }
}

resource "aws_instance" "windows-frontend" {
  count = 0
  tags  = "${merge(local.tags, map(
          "Name", "${local.prefix}windows-sql-${count.index}${local.suffix}",
          ))}"
  subnet_id                   = "${local.subnet_public_00}"
  associate_public_ip_address = true
  private_ip                  = "${var.frontend_private_ips[count.index]}"
  instance_type               = "t2.small"
  ami                         = "${data.aws_ami.w2k16.id}"
  key_name                    = local.personal-ssh
  vpc_security_group_ids      = [local.sg_admin,local.sg_internal]
  get_password_data           = true
  user_data                   = templatefile("./files/user_data_frontend.tpl", {
                                  peers = "${local.frontend_priv_ips}"
                                  automate_token = "${var.automate_token}"
                                  automate_url = "${var.automate_url}"
                                  automate_url_trn = "${var.automate_url_trn}"
                                  hab_token = "${var.hab_token}"
                                  node_name = "${local.prefix}windows-frontend-${count.index}${local.suffix}"
                                  debug = "false"
                                })
  #user_data                   = "${data.template_file.user_data_frontend.rendered}"
  connection {
    type      = "winrm"
    password  = "${rsadecrypt(self.password_data, file(var.ssh_key.file))}"
    agent     = "false"
    insecure  = true
    https     = false
    host      = self.public_ip
  }
}
