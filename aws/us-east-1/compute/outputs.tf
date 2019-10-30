output "windows-sql-login-data" {
  value = {
    for instance in aws_instance.windows-sql:
    instance.public_ip => "${rsadecrypt(instance.password_data, file(var.ssh_key.file))}"
  }
}

output "windows-frontend-login-data" {
  value = {
    for instance in aws_instance.windows-frontend:
    instance.public_ip => "${rsadecrypt(instance.password_data, file(var.ssh_key.file))}"
  }
}