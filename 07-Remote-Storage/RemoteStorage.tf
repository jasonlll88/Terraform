provider "aws" {
  region = "us-east-2"
  
}

# This define an AWS ec2 instance to be created	
resource "aws_instance" "ec2-instance-new" {
  ami           = "ami-036a034cc552b82e8"
  instance_type = "t2.micro"  
}

# Using a single workspace:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "jlrm-org"

    workspaces {
      name = "Dev-2"
    }
  }
}