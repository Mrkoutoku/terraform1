# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "test_demo" {
  cidr_block = "10.0.0.0/24"
  enable_dns_hostnames = true #DNSホスト名有効化
  tags = {
    Name = "test-demo-vpc"
  }
}

# ---------------------------
# Subnet
# ---------------------------
resource "aws_subnet" "test_demo" {
  vpc_id            = aws_vpc.test_demo.id
  cidr_block        = "10.0.0.0/25"
  availability_zone = "${var.az_a}"
  tags = {
    Name = "test-demo-subnet"
  }
}

# ---------------------------
# Internet Gateway
# ---------------------------
resource "aws_internet_gateway" "test_demo" {
  vpc_id = aws_vpc.test_demo.id
    tags = {
    Name = "test-demo-igw"
  }
}

# ---------------------------
# Elastic IP
# ---------------------------
resource "aws_eip" "test_demo" {
  domain   = "vpc"
  instance = aws_instance.test_demo.id
}

# ---------------------------
# Route table
# ---------------------------
# Route table作成
resource "aws_route_table" "test_demo" {
  vpc_id            = aws_vpc.test_demo.id
  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.test_demo.id
  }
  tags = {
    Name = "test-demo-public-rt"
  }
}

# SubnetとRoute tableの関連付け
resource "aws_route_table_association" "test_demo" {
  subnet_id      = aws_subnet.test_demo.id
  route_table_id = aws_route_table.test_demo.id
}

# ---------------------------
# Security Group
# ---------------------------
# Security Group作成
resource "aws_security_group" "test_demo" {
  name              = "test_demo"
  description       = "For EC2 Linux"
  vpc_id            = aws_vpc.test_demo.id
  tags = {
    Name = "test-demo"
  }

  # インバウンドルール
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
#    cidr_blocks = ["1.2.3.4/5"] #MyIP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}