resource "aws_vpc" "taskflow_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "mos-project-vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.taskflow_vpc.id
  cidr_block              = var.public_subnet_1
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "taskflow-public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.taskflow_vpc.id
  cidr_block              = var.public_subnet_2
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "taskflow-public-2"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.taskflow_vpc.id
  cidr_block              = var.private_subnet_1
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "taskflow-private-1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.taskflow_vpc.id
  cidr_block              = var.private_subnet_2
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "taskflow-private-2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.taskflow_vpc.id

  tags = {
    Name = "mos-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.taskflow_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "mos-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_eip" "nat" {
  domain = "vpc"


  tags = {
    Name = "taskflow-nat-eip"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "taskflow-nat-gateway"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.taskflow_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt.id
}
