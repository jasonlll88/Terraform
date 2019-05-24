In this example we are going to use an AWS S3 as a backend for remote storage, it's highly recommended to enable versioning on the bucket. [more information](https://www.terraform.io/docs/backends/types/s3.html)

We need to have an S3 bucket created.


If you have a backend previously configured run the init command with the flag reconfigure

`terraform init -reconfigure`

For locking we should have a DynamoDB table created with primary key named _LockID_, if this table is not present the locking will be disabled.

`terraform init`

`terraform apply`