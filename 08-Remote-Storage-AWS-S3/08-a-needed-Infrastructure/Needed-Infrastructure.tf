provider "aws" {
    region = "us-east-2"
}

# terraform state file setup
# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "terraform-state-storage-s3" {
    # Remember that this name should be globally unique
    bucket = "terraform-remote-state-storage-s3-ex"
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = false
    }
    force_destroy = true

}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}
