
provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Calculate total subnets
locals {
  total_public_subnets  = var.public_subnets_per_az * length(var.availability_zones)
  total_private_subnets = var.private_subnets_per_az * length(var.availability_zones)
}

# Public Subnets
resource "aws_subnet" "public" {
  count = local.total_public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone       = var.availability_zones[floor(count.index / var.public_subnets_per_az)]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = local.total_private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + local.total_public_subnets)
  availability_zone = var.availability_zones[floor(count.index / var.private_subnets_per_az)]

  tags = {
    Name = "Private-${count.index + 1}"
  }
}

# Associate Public Subnets to Public Route Table
resource "aws_route_table_association" "public_assoc" {
  count          = local.total_public_subnets
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}





# Adding NAT Gateway resources to your existing VPC setup

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  count = length(var.availability_zones)
  domain = "vpc"
}

# NAT Gateway - One per Availability Zone
resource "aws_nat_gateway" "nat" {
  count = length(var.availability_zones)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index * var.public_subnets_per_az].id

  tags = {
    Name = "NAT-${count.index + 1}"
  }
}

# Private Route Tables - One per AZ
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "Private-RT-${count.index + 1}"
  }
}

# Associate Private Subnets to their respective Private Route Table
resource "aws_route_table_association" "private_assoc" {
  count = local.total_private_subnets

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[floor(count.index / var.private_subnets_per_az)].id
}
