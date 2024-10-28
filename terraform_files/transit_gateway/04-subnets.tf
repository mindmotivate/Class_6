# Public Subnet for Production Environment
resource "aws_subnet" "public-us-east-1a" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.7.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true  # Ensures instances get public IPs

  tags = {
    Name = "public-us-east-1a"
    Environment = "production"
    Owner       = "Cloud_Bullies"
  }
}

# Private Subnet for Production Environment
resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.7.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-us-east-1a"
    Environment = "production"
    Owner       = "Cloud_Bullies"
  }
}

# Private Subnet for Development Environment
resource "aws_subnet" "private-us-east-1d" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.8.14.0/24"
  availability_zone = "us-east-1d"

  tags = {
    Name        = "private-us-east-1d"
    Environment = "development"
    Owner       = "Cloud_Bullies"
  }
}

# Private Subnet for Test Environment
resource "aws_subnet" "private-us-east-1f" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.9.16.0/24"
  availability_zone = "us-east-1f"

  tags = {
    Name        = "private-us-east-1f"
    Environment = "test"
    Owner       = "Cloud_Bullies"
  }
}