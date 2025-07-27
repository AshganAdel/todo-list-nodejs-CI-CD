resource "aws_security_group" "instance" {
  name        = "k3s-security_group"
  description = "Allow SSH, HTTP and k3s API"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = {
      ssh  = { port = 22, cidrs = ["0.0.0.0/0"] }
      http = { port = 8080, cidrs = ["0.0.0.0/0"] }
      k3s_api = { port = 6443, cidrs = ["0.0.0.0/0"]}
      nodeport = { port = 30080, cidrs = ["0.0.0.0/0"] }
    }
    content {
      description = ingress.key
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidrs
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k3s-security_group"
  }
}

resource "aws_instance" "ec2_control" {
  ami           = "ami-054b7fc3c333ac6d2"
  instance_type = "t3.micro"
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [ aws_security_group.instance.id ]
  tags = {
    Name = "control_plane"
  }
}

resource "aws_instance" "ec2_agent" {
  ami           = "ami-054b7fc3c333ac6d2"
  instance_type = "t3.micro"
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [ aws_security_group.instance.id ]
  tags = {
    Name = "agent"
  }
}

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ec2_key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/ec2_key.pem"
  file_permission = "0400"
}
