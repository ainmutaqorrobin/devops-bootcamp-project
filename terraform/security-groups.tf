
# public web server security group
resource "aws_security_group" "public_sg" {
  name        = "devops-public-sg"
  description = "Security group for public web server"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-public-sg"
  }
}

# private security group
resource "aws_security_group" "private_sg" {
  name        = "devops-private-sg"
  description = "Security group for private servers"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    description = "SSH from VPC (including public subnet)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-private-sg"
  }
}
