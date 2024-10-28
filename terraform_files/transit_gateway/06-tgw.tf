# Create a Transit Gateway with CIDR Block
resource "aws_ec2_transit_gateway" "tg" {
  description = "Transit Gateway for connecting prod, dev & test VPCs"

  # Specify the CIDR block for the Transit Gateway
  # transit_gateway_cidr_blocks = ["10.0.0.0/8"]  # Example CIDR block for Transit Gateway
  #default_route_table_association = "enable"
  #default_route_table_propagation = "enable"

  tags = {
    Name        = "Transit-Gateway"
    Environment = "development"
    Owner       = "Cloud_Bullies"
  }
}

# Create a Transit Gateway Attachment for the Production VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "prod_vpc_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.tg.id
  vpc_id            = aws_vpc.prod_vpc.id
  subnet_ids        = [aws_subnet.public-us-east-1a.id]  # Use the public subnet for attachment

  tags = {
    Name        = "prod-vpc-attachment"
    Environment = "production"
    Owner       = "Cloud_Bullies"
  }
}

# Create a Transit Gateway Attachment for the Development VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "dev_vpc_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.tg.id
  vpc_id            = aws_vpc.dev_vpc.id
  subnet_ids        = [aws_subnet.private-us-east-1d.id]  # Use the private subnet for attachment

  tags = {
    Name        = "dev-vpc-attachment"
    Environment = "development"
    Owner       = "Cloud_Bullies"
  }
}

# Create a Transit Gateway Attachment for the Test VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "test_vpc_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.tg.id
  vpc_id            = aws_vpc.test_vpc.id
  subnet_ids        = [aws_subnet.private-us-east-1f.id]  # Use the private subnet for attachment

  tags = {
    Name        = "test-vpc-attachment"
    Environment = "test"
    Owner       = "Cloud_Bullies"
  }
}
