# This makes vpc_a which is the Prodction Environemnt for N. Virgia region
resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.7.0.0/16"

  enable_dns_support   = true   # Enables DNS resolution in the VPC
  enable_dns_hostnames = true   # Ensures instances get DNS hostnames

  tags = {
    Name    = "vpc-a-virginia-prod"
    Environment = "production"
    Owner   = "Cloud_Bullies"
  }
}