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


#### Security Groups #######
resource "aws_security_group" "security_group_public" {
  name        = "terraform_public"
  description = "Used in the terraform for public instances"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # ICMP access from the anywhere
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#### EC2 Instances #######

resource "aws_instance" "ec2_instance_public" {
  key_name      = "eks-worker-nodes-key"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  ami           = "ami-0ebbf2179e615c338"
  # This role is to use the instance with the SSM system manager of AWS
  iam_instance_profile = "AmazonEC2RoleForSSM"
  vpc_security_group_ids = ["${aws_security_group.security_group_public.id}"]



}


resource "aws_instance" "ec2_instance_private" {
  key_name      = "eks-worker-nodes-key"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.private_subnet.id}"
  ami           = "ami-0ebbf2179e615c338"
  # This role is to use the instance with the SSM system manager of AWS
  iam_instance_profile = "AmazonEC2RoleForSSM"
  vpc_security_group_ids = ["${aws_security_group.security_group_public.id}"]

/*     connection {
    # The default username for our AMI
    user = "ec2-user"

    # The connection will use the local SSH agent for authentication.
  }

    provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sudo amazon-linux-extras install -y nginx1.12",
      "systemctl start nginx.service",
    ]
  } */

}