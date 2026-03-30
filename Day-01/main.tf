resource "aws_instance" "my_instance" {
  ami                    = data.aws_ami.selected.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name               = aws_key_pair.my_key.key_name
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
  tags = {
    "Name" = "Terra-Auto_server"
  }

}

resource "aws_key_pair" "my_key" {
  key_name   = "terra-auto-key"
  public_key = tls_private_key.my_key.public_key_openssh
}

resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.my_key.private_key_pem
  filename        = "${path.module}/terra-auto-key.pem"
  file_permission = 0600
}
resource "aws_security_group" "my_sg" {
  name   = "my_sg"
  vpc_id = aws_default_vpc.default.id #interpolation (getting id of another resource)
}

resource "aws_default_vpc" "default" {
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.my_sg.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.my_sg.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = local.s3_bucket_name_final
  tags = {
    "Name" = "Terra-Auto_bucket"
  }
}

resource "time_static" "today" {}

resource "random_integer" "suffix" {
  min = 1
  max = 99
}
