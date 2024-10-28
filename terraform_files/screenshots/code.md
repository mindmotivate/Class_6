### Let's set up the AWS provider in "us-east-1" with version 3.x.

```php
provider "aws" {
  region = "us-east-1" # Set AWS region to us-east-1
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Specify the provider source as HashiCorp's AWS provider
      version = "~> 3.0"        # Use any version compatible with 3.x
    }
  }
}
```



### Let's create a VPC with tags specifying application and ownership information.
```php

resource "aws_vpc" "app1" {
  cidr_block = "10.8.0.0/16"

  tags = {
    Name    = "app1"
    Service = "application1"
    Owner   = "Class6"
    Group   = "Cloud_Bullies"
  }
}
```

### Let's define both public and private subnets within the created VPC, with tags and availability zones.

```php
# Public subnet in us-east-1a, attached to the VPC and with public IP mapping enabled
resource "aws_subnet" "public-us-east-1a" {
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.8.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1a"
    Service = "application1"
    Owner   = "Class6"
    Group   = "Cloud_Bullies"
  }
}

# Public subnet in us-east-1b, attached to the VPC and with public IP mapping enabled
resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.8.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1b"
    Service = "application1"
    Owner   = "Class6"
    Group   = "Cloud_Bullies"
  }
}

# Public subnet in us-east-1c, attached to the VPC and with public IP mapping enabled
resource "aws_subnet" "public-us-east-1c" {
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.8.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1c"
    Service = "application1"
    Owner   = "Class6"
    Group   = "Cloud_Bullies"
  }
}

# Private subnet in us-east-1a, attached to the VPC without public IP mapping
resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.8.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name    = "private-us-east-1a"
    Service = "application1"
    Owner   = "Class6"
    Group   = "Cloud_Bullies"
  }
}

# Private subnet in us-east-1b, attached to the VPC without public IP mapping
resource "aws_subnet" "private-us-east-1b" {
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.8.12.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name    = "private-us-east-1b"
    Service = "application1"
    Owner   = "Class6"
    Group   = "Cloud_Bullies"
  }
}

# Private subnet in us-east-1c, attached to the VPC without public IP mapping
resource "aws_subnet" "private-us-east-1c" {
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.8.13.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name    = "private-us-east-1c"
    Service = "application1"
    Owner   = "Class6"
    Group   = "Cloud_Bullies"
  }
}
```

### Internet Gateway

```php
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app1.id

  tags = {
    Name    = "app1_IG"
    Service = "application1"
    Owner   = "Luke"
    Planet  = "Musafar"
  }
}
```
### Elastic IP for NAT Gateway

```php
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}
```
### NAT Gateway
```php
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
```
### Private Route Table
```php
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app1.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.nat.id
    },
  ]

  tags = {
    Name = "private"
  }
}
```

### Public Route Table
```php
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app1.id

  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    },
  ]

  tags = {
    Name = "public"
  }
}
```
### Private Route Table Associations
```php
resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.private-us-east-1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = aws_subnet.private-us-east-1b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-east-1c" {
  subnet_id      = aws_subnet.private-us-east-1c.id
  route_table_id = aws_route_table.private.id
}
```

### Public Route Table Associations
```php
resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.public-us-east-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.public-us-east-1b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-1c" {
  subnet_id      = aws_subnet.public-us-east-1c.id
  route_table_id = aws_route_table.public.id
}
```