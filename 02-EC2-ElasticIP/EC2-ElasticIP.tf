/* 
###### This example contains implicit dependencies #####

# This is the cloud provider
#     If don't use parameters of access_key and secret_key it will find for the credentials of AWS in the file ~/.aws/credentials

provider "aws" {
  region     = "us-east-2"
}

# This define an AWS ec2 instance to be created

resource "aws_instance" "my-first-ec2-instance" {
  ami           = "ami-0ebbf2179e615c338"
  instance_type = "t2.micro"
}

# This define the elastic ip resoruce to be created
resource "aws_eip" "eip" {
  instance = "${aws_instance.my-first-ec2-instance.id}"
} */


###### This example contains explicit dependencies #####

# This is the cloud provider
#     If don't use parameters of access_key and secret_key it will find for the credentials of AWS in the file ~/.aws/credentials

provider "aws" {
  region     = "us-east-2"
}

# This define an AWS ec2 instance to be created

resource "aws_instance" "my-first-ec2-instance" {
  ami           = "ami-0ebbf2179e615c338"
  instance_type = "t2.micro"

  # This is accepted by any resource
  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = ["aws_s3_bucket.my-first-s3-bucket"]
}

# This define the S3 bucket
resource "aws_s3_bucket" "my-first-s3-bucket" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "my-first-s3-bucket-0000001"
  acl    = "private"
}
