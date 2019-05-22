provider "aws" {
    region = "${var.region}"
}

resource "aws_instance" "my-first-ec2-instance" {
    ami           = "ami-036a034cc552b82e8"
    instance_type = "t2.micro"


    tags = {
    Name = "${var.name_of_instance}"
  }
}