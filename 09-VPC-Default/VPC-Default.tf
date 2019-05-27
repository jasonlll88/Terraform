provider "aws" {
  region = "${var.region}"
}

# Create the VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "${var.cidr_block_vpc}"
  tags = {
    Name = "my_vpc"
  }
}

# Create a subnet that will be the public one
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "${var.cidr_block_public_subnet}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# Create a subnet that will be the private one
resource "aws_subnet" "private_subnet" {
  vpc_id     = "${aws_vpc.my_vpc.id}"
  cidr_block = "${var.cidr_block_private_subnet}"

  tags = {
    Name = "private_subnet"
  }
}


# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"
}

# Create a EIP for gateway
resource "aws_eip" "eip-ngw" {
  vpc = true
}

# Create a NAT gateway to give our private subnet access to the outside world
resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.eip-ngw.id}"
  subnet_id     = "${aws_subnet.private_subnet.id}"
}

# Create route table for private net with associtation of nat gtw
resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.my_vpc.id}"


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.ngw.id}"

  }
}

# Associtate the route table of the private net as a main table
resource "aws_main_route_table_association" "association_main_route_table" {
  vpc_id         = "${aws_vpc.my_vpc.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

# Create the public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"

  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "association_public_subnet" {
  route_table_id = "${aws_route_table.public_route_table.id}"
  subnet_id      = "${aws_subnet.public_subnet.id}"
}

# Associate the private subnet with the private woute table
resource "aws_route_table_association" "association_private_subnet" {
  route_table_id = "${aws_route_table.private_route_table.id}"
  subnet_id      = "${aws_subnet.private_subnet.id}"
}

