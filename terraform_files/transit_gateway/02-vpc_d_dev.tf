# This makes vpc_b which is the Development Environment
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.8.0.0/16"

  tags = {
    Name        = "vpc-d-virginia-dev"
    Environment = "development"
    Owner       = "Cloud_Bullies"
  }
}