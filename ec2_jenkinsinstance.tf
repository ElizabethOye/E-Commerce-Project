resource "aws_instance" "ec2_jenkinsinstance" {
  ami             = data.aws_ssm_parameter.instance_ami.value
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.sg.id]
  key_name        = var.keyname
  user_data       = fileexists("install_apache.sh") ? file("install_apache.sh") : null
  tags = {
    "NAME" = "ec2_jenkinsinstance"
  }
}