resource "aws_security_group" "vpc-a-prod-windows-bastion-sg" {
  name        = "vpc-a-prod-windows-bastion-sg"
  description = "vpc-a-prod-windows-bastion-sg"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

/*
  ingress {
    description = "ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "vpc-a-prod-windows-bastion-sg"
    Service = "bastion-host"
    Owner   = "Cloud-Bullies"
  }

}



resource "aws_security_group" "vpc-d-dev-linux-instance-sg" {
  name        = "vpc-d-dev-linux-instance-sg"
  description = "vpc-d-dev-linux-instance-sg"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description = "allow-ping-from-bastion"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "vpc-d-dev-linux-instance-sg"
    Service = "linux-dev-instance"
    Owner   = "Cloud-Bullies"
  }

}




