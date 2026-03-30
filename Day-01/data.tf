locals {
  ami_filters = {
    ubuntu = {
      pattern = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
      owner   = "099720109477" # Canonical
    },
    amazon = {
      pattern = "al2023-ami-2023*-x86_64"
      owner   = "amazon"
    },
    rhel = {
      pattern = "RHEL-9*-x86_64-*"
      owner   = "309956199498" # Red Hat
    }
  }
}

data "aws_ami" "selected" {
  most_recent = true
  owners      = [local.ami_filters[lower(var.os_type)].owner]
  filter {
    name   = "name"
    values = [local.ami_filters[lower(var.os_type)].pattern]
  }
}