#### vpc ####
resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames

  tags = {
    Name = "dev-vpc"
  }
}

#### subnet ####
resource "aws_subnet" "dev_subnet_public" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.subnetCIDRblock1
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZonePub
  tags = {
    Name = "dev-subnet-public"
  }
}

resource "aws_subnet" "dev_subnet_private" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.subnetCIDRblock2
  map_public_ip_on_launch = false
  availability_zone       = var.availabilityZonePriv
  tags = {
    Name = "dev-subnet-private"
  }
}

#### security group ####
resource "aws_security_group" "dev_security_group_private" {
  vpc_id      = aws_vpc.dev_vpc.id
  name        = "dev security group private"
  description = "dev security group private"
  ingress {
    security_groups = [aws_security_group.dev_security_group_public.id]
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    Name = "dev-security-group-private"
  }
}

resource "aws_security_group" "dev_security_group_public" {
  vpc_id      = aws_vpc.dev_vpc.id
  name        = "dev security group public"
  description = "dev security group public"
  ingress {
    cidr_blocks = ["218.147.172.17/32"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = [var.ingressCIDRblockPub]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = {
    Name = "dev-security-group-private"
  }
}

#### internet gateway ####
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-IGW"
  }
}

#### route table ####
resource "aws_route_table" "dev_public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-public-route-table"
  }
}

resource "aws_route_table" "dev_private_route_table" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-private-route-table"
  }
}

#### internet access, route ####
resource "aws_route" "dev_internet_access" {
  route_table_id         = aws_route_table.dev_public_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.dev_igw.id
}

#### Associate route table with subnet ####
resource "aws_route_table_association" "dev_public_association" {
  subnet_id      = aws_subnet.dev_subnet_public.id
  route_table_id = aws_route_table.dev_public_route_table.id
}

resource "aws_route_table_association" "dev_private_association" {
  subnet_id      = aws_subnet.dev_subnet_private.id
  route_table_id = aws_route_table.dev_private_route_table.id
}

#### s3 bucket ####
resource "aws_s3_bucket" "tfendpoint" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "dev-endpoint-bucket"
    Environment = "vpc-endpoint-test"
  }
}