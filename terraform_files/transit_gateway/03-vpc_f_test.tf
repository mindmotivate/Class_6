# This makes vpc_c which is the Test Environment
resource "aws_vpc" "test_vpc" {
  cidr_block = "10.9.0.0/16"

  tags = {
    Name        = "vpc-f-virginia-test"
    Environment = "test"
    Owner       = "Cloud_Bullies"
  }
}