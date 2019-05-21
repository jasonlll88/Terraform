/* This is the cloud provider
	These three parameters should be set up with yours 		
*/
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-2"
}

/* This define an AWS ec2 instance to be created	
*/
resource "aws_instance" "my-first-ec2-instance" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
