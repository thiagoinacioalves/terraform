resource "aws_security_group" "ssh-acesso" {
  name        = "ssh-acesso"
  description = "Allow ssh inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidrs_acesso_remoto
  }
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "ssh-acesso-us-east-2" {
  provider    =  aws.us-east-2
  name        = "ssh-acesso-us-east-2"
  description = "Allow ssh inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidrs_acesso_remoto #ip externo para acesso
  }
  tags = {
    Name = "allow_ssh"
  }
}