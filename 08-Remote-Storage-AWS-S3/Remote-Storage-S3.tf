provider "aws" {
  region = "us-east-2"
  
}

# This define an AWS ec2 instance to be created	
resource "aws_instance" "ec2-instance-new" {
  ami           = "ami-036a034cc552b82e8"
  instance_type = "t2.micro"  
}

# Configuration for an S3 in AWS
terraform {
  backend "s3" {
    # name of the bucket where it's going to write
    bucket = "terraform-remote-state-storage-s3-ex"
    # Key where it will write including the name of the file
    key    = "dev-3/terraform_dev.tfstate"
    region = "us-east-2"

    # Name of the dynamoDB table
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}