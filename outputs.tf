output "ec2_public_ip" {
  value = module.app-webserver.webserver-instance.public_ip
}
