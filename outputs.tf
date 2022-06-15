output "aws_ami_id" {
  value = data.aws_ami.lastest-amazon-linux-image.id
}

output "ec2_public_ip" {
  value = aws_instance.webserver.public_ip
}
