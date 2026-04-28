# VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name       = "${var.vpc_name}-vpc"
    Managed_by = "${var.managed_by}"
  }
}

# Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name       = "${var.vpc_name}-public-subnet"
    Managed_by = "${var.managed_by}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name       = "${var.vpc_name}-igw"
    Managed_by = "${var.managed_by}"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.tf_vpc.id
    tags = {
    Name       = "${var.vpc_name}-rt"
    Managed_by = "${var.managed_by}"
  }
}

# Route
resource "aws_route" "internet" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Route Table
resource "aws_route_table_association" "assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

# Security Group
resource "aws_security_group" "sg" {
  name   = "allow-ssh-http"
  vpc_id = aws_vpc.tf_vpc.id
    tags = {
    Name       = "${var.vpc_name}-sg"
    Managed_by = "${var.managed_by}"
  }  

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
