resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name       = "vpc-a-virginia-prod-igw"
    Environment = "production"
    Owner      = "Cloud_Bullies"
  }
}
