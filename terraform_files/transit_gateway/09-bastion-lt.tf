resource "aws_instance" "windows_bastion" {
  ami             = "ami-0324a83b82023f0b3"    # Windows Server AMI
  instance_type   = "t2.medium"                # Instance type

  # Use the security group ID instead of name for better reliability
  vpc_security_group_ids = [aws_security_group.vpc-a-prod-windows-bastion-sg.id]

  # Subnet where the instance will be launched (make sure this is a public subnet)
  subnet_id = aws_subnet.public-us-east-1a.id  # Use the appropriate public subnet

  tags = {
    Name    = "windows_bastion"
    Service = "bastion-host"
    Owner   = "Cloud_Bullies"
  }

  # Specify the key pair name for SSH access
  key_name = "vpc-a-prod"  # Your existing key pair name

  # Ensure to assign a public IP
  associate_public_ip_address = true
}
