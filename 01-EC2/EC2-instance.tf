/* This is the cloud provider
	These three parameters should be set up with yours 		

provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-2"
}
*/

/* This is the cloud provider
        If don't use parameters of access_key and secret_key it will find for the credentials of AWS in the file ~/.aws/credentials
*/
provider "aws" {
  region     = "us-east-2"
}




/* This define an AWS ec2 instance to be created	
*/
resource "aws_instance" "my-first-ec2-instance" {
  ami           = "ami-036a034cc552b82e8"
  instance_type = "t2.micro"
}
