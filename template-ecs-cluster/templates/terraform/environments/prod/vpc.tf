# Create a new VPC
resource "aws_vpc" "prod" {
  cidr_block = var.cidr
  tags = {
    Name = var.vpc_name
  }
}

# Create a public subnet in the VPC
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.public_subnet
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "prod-public-subnet"
  }
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.public_subnet2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "prod-public-subnet"
  }
}

# Create a private subnet in the VPC
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.private_subnet
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "prod-private-subnet"
  }
}

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.private_subnet2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "prod-private-subnet"
  }
}

# Create an internet gateway for the VPC
resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "prod-internet-gateway"
  }
}

# Create a public route table and associate it with the public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  }
  tags = {
    Name = "prod-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# Create a private route table and associate it with the private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "prod-private-route-table"
  }
}

resource "aws_route" "private_nat_gateway" {
  route_table_id = aws_route_table.private.id
  nat_gateway_id = aws_nat_gateway.prod.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

# Create a NAT gateway in the public subnet and associate it with the public route table
resource "aws_nat_gateway" "prod" {
  allocation_id = aws_eip.prod.id
  subnet_id = aws_subnet.public.id
  tags = {
    Name = "prod-nat-gateway"
  }
}

# Create an Elastic IP address for the NAT gateway
resource "aws_eip" "prod" {
  vpc = true
  tags = {
    Name = "prod-nat-gateway-eip"
  }
}
