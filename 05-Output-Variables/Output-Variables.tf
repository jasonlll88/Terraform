provider "aws" {
  region = "us-east-2"
}


# This define an AWS ec2 instance to be created
resource "aws_instance" "my-ec2-instance" {
  ami           = "ami-0ebbf2179e615c338"
  instance_type = "t2.micro"
}


# This define the elastic ip resoruce to be created
resource "aws_eip" "eip" {
  instance = "${aws_instance.my-ec2-instance.id}"
}

# Define the outputs
output "eip" {
  value = "${aws_eip.eip.public_ip}"
}