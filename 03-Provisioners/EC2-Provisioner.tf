# This is the cloud provider
#     If don't use parameters of access_key and secret_key it will find for the credentials of AWS in the file ~/.aws/credentials

provider "aws" {
  region     = "us-east-2"
}

# This define an AWS ec2 instance to be created

resource "aws_instance" "my-first-ec2-instance" {
  ami           = "ami-0ebbf2179e615c338"
  instance_type = "t2.micro"

  provisioner "local-exec" {
      command = "echo ${aws_instance.my-first-ec2-instance.public_ip} > ip_address.txt"
  }
}