# Route Table for Production VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
resource "aws_route_table" "prod_route_table" {
   # default_route_table_id = aws_vpc.prod_vpc.default_route_table_id
   vpc_id = aws_vpc.prod_vpc.id

  #route {
    # Route for local communication within the Production VPC
    # cidr_block = "10.7.0.0/16"  # Production VPC CIDR
    # This route is local by default, so no target is needed
  #}

  route {
    # Route for Internet Access
    cidr_block = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.igw.id
  }

  route {
    # Route to Transit Gateway
    cidr_block = "10.0.0.0/8"  # CIDR for Transit Gateway
    transit_gateway_id      = aws_ec2_transit_gateway.tg.id
  }

  tags = {
    Name        = "prod-route-table"
    Environment = "production"
    Owner       = "Cloud_Bullies"
  }
}

resource "aws_route_table_association" "public_prod_subnet_association" {
  subnet_id      = aws_subnet.public-us-east-1a.id
  route_table_id = aws_route_table.prod_route_table.id
}


# Route Table for Development VPC
resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

# route {
    # Route for local communication within the Development VPC
#    cidr_block = "10.8.0.0/16"  # Development VPC CIDR
    # This route is local by default, so no target is needed
#}

  route {
    # Route to Transit Gateway
    cidr_block = "10.0.0.0/8"  # CIDR for Transit Gateway
    transit_gateway_id      = aws_ec2_transit_gateway.tg.id
  }

  tags = {
    Name        = "dev-route-table"
    Environment = "development"
    Owner       = "Cloud_Bullies"
  }
}

resource "aws_route_table_association" "private_dev_subnet_association" {
  subnet_id      = aws_subnet.private-us-east-1d.id
  route_table_id = aws_route_table.dev_route_table.id
}

# Route Table for Test VPC
resource "aws_route_table" "test_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  #route {
    # Route for local communication within the Test VPC
    #cidr_block = "10.9.0.0/16"  # Test VPC CIDR
    # This route is local by default, so no target is needed
  #}

  route {
    # Route to Transit Gateway
    cidr_block = "10.0.0.0/8"  # CIDR for Transit Gateway
    transit_gateway_id      = aws_ec2_transit_gateway.tg.id
  }

  tags = {
    Name        = "test-route-table"
    Environment = "test"
    Owner       = "Cloud_Bullies"
  }
}

resource "aws_route_table_association" "privtae_1f_subnet_association" {
  subnet_id      = aws_subnet.private-us-east-1f.id
  route_table_id = aws_route_table.test_route_table.id
}