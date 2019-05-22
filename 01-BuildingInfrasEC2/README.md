For this example we're going to use AWS as a cloud provider, for the purpose of this you should create an account in AWS if you don't have one.

The files for terraform have the extension *.tf

The file to launch an ec2 instance in AWS is
launch-EC2-instance.tf

In order to don't upload any of the credentials to this public repo we use the provider without any access and secret key, doing that it look for the credentials in the file ~/.aws/credentials


#### Follow the next step to deploy this in your AWS account

- This command download and configure the necesary files to achieve the configuration in your AWS account.

	`terraform init`


- This command will show you what changes are going to be applied.

	`terraform plan`

- This command apply the changes.

	`terraform apply`

- This command will destroy the created infrastructure.

	`terraform destroy`


## Troubleshootings

 - You could have problem with the VPC, this will work with the [default VPC](https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html?shortFooter=true#create-default-vpc)
 - You could have problem with the AMI parameter, so you should verify the available images for the selected zone [more information](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html?shortFooter=true#finding-an-ami-console)

