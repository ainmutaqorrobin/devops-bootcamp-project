resource "aws_iam_role" "ec2_ssm_role" {
  name = "devops-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "devops-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}

data "aws_ami" "ubuntu_2404" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


# web server
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.ubuntu_2404.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  private_ip                  = "10.0.0.5"
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_profile.name
  key_name                    = aws_key_pair.ansible.key_name

  tags = {
    Name = "devops-web-server"
  }
}

# elastic ip for web server
resource "aws_eip" "web_eip" {
  instance = aws_instance.web_server.id
  domain   = "vpc"

  tags = {
    Name = "devops-web-eip"
  }
}

# ansible controller (private)
resource "aws_instance" "ansible_controller" {
  ami                    = data.aws_ami.ubuntu_2404.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet.id
  private_ip             = "10.0.0.135"
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name
  key_name               = aws_key_pair.ansible.key_name

  tags = {
    Name = "devops-ansible-controller"
  }
}

# monitoring server (private)
resource "aws_instance" "monitoring_server" {
  ami                    = data.aws_ami.ubuntu_2404.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet.id
  private_ip             = "10.0.0.136"
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name
  key_name               = aws_key_pair.ansible.key_name

  tags = {
    Name = "devops-monitoring-server"
  }
}
