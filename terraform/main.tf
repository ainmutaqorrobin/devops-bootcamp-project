resource "aws_vpc" "devops_vpc" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "devops-vpc"
  }
}

# public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.0.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "devops-public-subnet"
  }
}

# private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.0.0.128/25"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "devops-private-subnet"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops-igw"
  }
}

# elastic IP for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "devops-nat-eip"
  }
}

# NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "devops-ngw"
  }

  depends_on = [aws_internet_gateway.igw]
}

# public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "devops-public-route"
  }
}

# private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "devops-private-route"
  }
}

# route table associations
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# ECR repository for container images
resource "aws_ecr_repository" "final_project" {
  name                 = "devops-bootcamp/final-project-robin"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "devops-bootcamp-ecr"
  }
}
