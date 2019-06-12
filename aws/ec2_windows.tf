# # Create a new EC2 instance with Chef as provisioner
# resource "aws_instance" "windows-nh" {
#   count = 0
#   provisioner "chef" {
#     environment               = "_default"
#     log_to_file               = "${var.chef_log}"
#     node_name                 = "windows-s2k12r2-nh"
#     run_list                  = ["recipe[dbright-io-base-windows-nh]"]
#     server_url                = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
#     user_name                 = "${var.chef_user["username"]}"
#     user_key                  = "${file(".chef/user.pem")}"
#     fetch_chef_certificates   = true
#     #version                   = "${var.chef_versions["client"]}"
#     recreate_client           = true
#   }
#   tags                        = "${merge(var.default_tags, map(
#                                   "Name", "${var.prefix}-windows-nh-${count.index}",
#                                 ))}"
#   subnet_id                   = "${aws_subnet.public_00.id}"
#   associate_public_ip_address = true
#   connection {
#     host                      = "${self.public_ip}"
#     type                      = "winrm"
#     user                      = "${var.windows_user["username"]}"
#     password                  = "${var.windows_user["password"]}"
#   }
#   instance_type               = "t2.medium"
#   ami                         = "ami-05f5c28bb6992ab4b"
#   key_name                    = "${aws_key_pair.personal.id}"
#   vpc_security_group_ids      = ["${aws_security_group.admin.id}","${aws_security_group.internal.id}"]
# //     user_data                   = <<EOF
# //     <script>
# //       winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
# //     </script>
# //     <powershell>
# //       netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
# //       $admin = [adsi]("WinNT://./administrator, user")
# //       $admin.psbase.invoke("SetPassword", "${var.windows_bastion_user["password"]}")
# //       If ((Get-Content "$($env:windir)\system32\Drivers\etc\hosts" ) -notcontains "${aws_instance.chef-server.public_ip} ${var.chef-server.fqdn}")
# //       {ac -Encoding UTF8  "$($env:windir)\system32\Drivers\etc\hosts" "${aws_instance.chef-server.public_ip} ${var.chef-server-fqdn}" }
# //     </powershell>
# // EOF
#   user_data                   = <<EOF
#     <script>
#       winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
#     </script>
#     <powershell>
#       netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
#       $admin = [adsi]("WinNT://./administrator, user")
#       $admin.psbase.invoke("SetPassword", "${var.windows_user["password"]}")
#     </powershell>
# EOF
# }

# # Show the public IP address at the end
# output "windows-nh-address" {
#   value = "${aws_instance.windows-nh.*.public_ip}"
# }

# resource "aws_instance" "windows-h" {
#   count = 0
#   provisioner "chef" {
#     environment               = "_default"
#     log_to_file               = "${var.chef_log}"
#     node_name                 = "windows-s2k12r2-h"
#     run_list                  = ["recipe[dbright-io-base-windows-nh::default]"]
#     server_url                = "https://chef-server.dbright.io/organizations/${var.chef_org["short"]}"
#     user_name                 = "${var.chef_user["username"]}"
#     user_key                  = "${file(".chef/user.pem")}"
#     fetch_chef_certificates   = true
#     #version                   = "${var.chef_versions["client"]}"
#     recreate_client           = true
#   }
#   tags                        = "${merge(var.default_tags, map(
#                                   "Name", "${var.prefix}-windows-h-${count.index}",
#                                 ))}"
#   subnet_id                   = "${aws_subnet.public_00.id}"
#   associate_public_ip_address = true
#   connection {
#     host                      = "${self.public_ip}"
#     type                      = "winrm"
#     user                      = "${var.windows_user["username"]}"
#     password                  = "${var.windows_user["password"]}"
#   }
#   instance_type               = "t2.medium"
#   ami                         = "ami-05f5c28bb6992ab4b"
#   key_name                    = "${aws_key_pair.personal.id}"
#   vpc_security_group_ids      = ["${aws_security_group.admin.id}","${aws_security_group.internal.id}"]
# //     user_data                   = <<EOF
# //     <script>
# //       winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
# //     </script>
# //     <powershell>
# //       netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
# //       $admin = [adsi]("WinNT://./administrator, user")
# //       $admin.psbase.invoke("SetPassword", "${var.windows_bastion_user["password"]}")
# //       If ((Get-Content "$($env:windir)\system32\Drivers\etc\hosts" ) -notcontains "${aws_instance.chef-server.public_ip} ${var.chef-server.fqdn}")
# //       {ac -Encoding UTF8  "$($env:windir)\system32\Drivers\etc\hosts" "${aws_instance.chef-server.public_ip} ${var.chef-server-fqdn}" }
# //     </powershell>
# // EOF
#   user_data                   = <<EOF
#     <script>
#       winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
#     </script>
#     <powershell>
#       netsh advfirewall firewall add rule name="WinRM in 5985" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
#       netsh advfirewall firewall add rule name="WinRM in 5986" protocol=TCP dir=in profile=any localport=5986 remoteip=any localip=any action=allow
#       $admin = [adsi]("WinNT://./administrator, user")
#       $admin.psbase.invoke("SetPassword", "${var.windows_user["password"]}")
#     </powershell>
# EOF
# }

# # Show the public IP address at the end
# output "windows-h-address" {
#   value = "${aws_instance.windows-h.*.public_ip}"
# }