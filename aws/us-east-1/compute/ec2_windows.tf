# Create a new EC2 instance with Chef as provisioner
resource "aws_instance" "windows-a" {
  count = 0
  provisioner "chef" {
    environment               = "_default"
    node_name                 = "windows-s2k12r2-a-${count.index}"
    run_list                  = ["recipe[eg-win-role-cookbook-a]"]
    server_url                = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
    user_name                 = "${var.chef_user["username"]}"
    user_key                  = "${file(".chef/user.pem")}"
    fetch_chef_certificates   = true
    #version                   = "${var.chef_versions["client"]}"
    recreate_client           = true
  }
  tags                        = "${merge(data.terraform_remote_state.static.default_tags, map(
                                  "Name", "${local.prefix}-windows-a-${count.index}",
                                ))}"
  subnet_id                   = "${local.subnet_public_00}"
  associate_public_ip_address = true
  connection {
    host                      = "${self.public_ip}"
    type                      = "winrm"
    user                      = "${var.windows_user["username"]}"
    password                  = "${var.windows_user["password"]}"
  }
  instance_type               = "t2.medium"
  ami                         = "ami-0e3fbebfa69d4c85c"
  key_name                    = "${aws_key_pair.personal.id}"
  vpc_security_group_ids      = ["${local.sg_admin}","${local.sg_internal}"]
//     user_data                   = <<EOF
//     <script>
//       winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
//     </script>
//     <powershell>
//       netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
//       $admin = [adsi]("WinNT://./administrator, user")
//       $admin.psbase.invoke("SetPassword", "${var.windows_bastion_user["password"]}")
//       If ((Get-Content "$($env:windir)\system32\Drivers\etc\hosts" ) -notcontains "${aws_instance.chef-server.public_ip} ${var.chef-server.fqdn}")
//       {ac -Encoding UTF8  "$($env:windir)\system32\Drivers\etc\hosts" "${aws_instance.chef-server.public_ip} ${var.chef-server-fqdn}" }
//     </powershell>
// EOF
  user_data                   = <<EOF
    <script>
      winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
    </script>
    <powershell>
      netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
      $admin = [adsi]("WinNT://./administrator, user")
      $admin.psbase.invoke("SetPassword", "${var.windows_user["password"]}")
    </powershell>
EOF
}

resource "aws_instance" "windows-a2" {
  count = 1
  provisioner "chef" {
    environment               = "_default"
    node_name                 = "windows-s2k12r2-a-${count.index}"
    run_list                  = ["recipe[eg-win-role-cookbook-a]"]
    server_url                = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
    user_name                 = "${var.chef_user["username"]}"
    user_key                  = "${file(".chef/user.pem")}"
    fetch_chef_certificates   = true
    #version                   = "${var.chef_versions["client"]}"
    recreate_client           = true
  }
  tags                        = "${merge(data.terraform_remote_state.static.default_tags, map(
                                  "Name", "${local.prefix}-windows-a-${count.index}",
                                ))}"
  subnet_id                   = "${local.subnet_public_00}"
  associate_public_ip_address = true
  connection {
    host                      = "${self.public_ip}"
    type                      = "winrm"
    user                      = "${var.windows_user["username"]}"
    password                  = "${var.windows_user["password"]}"
  }
  instance_type               = "t2.medium"
  ami                         = "ami-0e3fbebfa69d4c85c"
  key_name                    = "${aws_key_pair.personal.id}"
  vpc_security_group_ids      = ["${local.sg_admin}","${local.sg_internal}"]
//     user_data                   = <<EOF
//     <script>
//       winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
//     </script>
//     <powershell>
//       netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
//       $admin = [adsi]("WinNT://./administrator, user")
//       $admin.psbase.invoke("SetPassword", "${var.windows_bastion_user["password"]}")
//       If ((Get-Content "$($env:windir)\system32\Drivers\etc\hosts" ) -notcontains "${aws_instance.chef-server.public_ip} ${var.chef-server.fqdn}")
//       {ac -Encoding UTF8  "$($env:windir)\system32\Drivers\etc\hosts" "${aws_instance.chef-server.public_ip} ${var.chef-server-fqdn}" }
//     </powershell>
// EOF
  user_data                   = <<EOF
    <script>
      winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
    </script>
    <powershell>
      netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
      $admin = [adsi]("WinNT://./administrator, user")
      $admin.psbase.invoke("SetPassword", "${var.windows_user["password"]}")
    </powershell>
EOF
}

resource "aws_instance" "windows-b" {
  count = 0
  provisioner "chef" {
    environment               = "_default"
    node_name                 = "windows-s2k12r2-b-${count.index}"
    run_list                  = ["recipe[eg-windows-role-b]"]
    server_url                = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
    user_name                 = "${var.chef_user["username"]}"
    user_key                  = "${file(".chef/user.pem")}"
    fetch_chef_certificates   = true
    #version                   = "${var.chef_versions["client"]}"
    recreate_client           = true
  }
  tags                        = "${merge(data.terraform_remote_state.static.default_tags, map(
                                  "Name", "${local.prefix}-windows-b-${count.index}",
                                ))}"
  subnet_id                   = "${local.subnet_public_00}"
  associate_public_ip_address = true
  connection {
    host                      = "${self.public_ip}"
    type                      = "winrm"
    user                      = "${var.windows_user["username"]}"
    password                  = "${var.windows_user["password"]}"
  }
  instance_type               = "t2.medium"
  ami                         = "ami-05f5c28bb6992ab4b"
  key_name                    = "${aws_key_pair.personal.id}"
  vpc_security_group_ids      = ["${local.sg_admin}","${local.sg_internal}"]
//     user_data                   = <<EOF
//     <script>
//       winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
//     </script>
//     <powershell>
//       netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
//       $admin = [adsi]("WinNT://./administrator, user")
//       $admin.psbase.invoke("SetPassword", "${var.windows_bastion_user["password"]}")
//       If ((Get-Content "$($env:windir)\system32\Drivers\etc\hosts" ) -notcontains "${aws_instance.chef-server.public_ip} ${var.chef-server.fqdn}")
//       {ac -Encoding UTF8  "$($env:windir)\system32\Drivers\etc\hosts" "${aws_instance.chef-server.public_ip} ${var.chef-server-fqdn}" }
//     </powershell>
// EOF
  user_data                   = <<EOF
    <script>
      winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
    </script>
    <powershell>
      netsh advfirewall firewall add rule name="WinRM in 5985" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
      netsh advfirewall firewall add rule name="WinRM in 5986" protocol=TCP dir=in profile=any localport=5986 remoteip=any localip=any action=allow
      $admin = [adsi]("WinNT://./administrator, user")
      $admin.psbase.invoke("SetPassword", "${var.windows_user["password"]}")
    </powershell>
EOF
}
