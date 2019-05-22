This example will show the resource dependency creating an ElaticIP resource and associating it to the EC2 instance

The tf file to run is EC2-ElasticIP.tf

In the file there two examples one with implicit dependencies and the other with explicit, just uncomment what you want to apply.

Sometimes there are dependencies between resources that are not visible to Terraform. The _depends_on_ argument is accepted by any resource and accepts a list of resources to create explicit dependencies for.

Don't forget to run first 
`terraform init`

Then
`terraform apply`


