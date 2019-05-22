# This is the provider AWS
provider "aws" {
    region = "us-east-2"
  
}

# This is the module for consul (service mesh https://www.hashicorp.com/products/consul/)
module "consul" {
    # this attribute is mandatory fo modules
    source = "hashicorp/consul/aws"
    num_servers = "3"
}

output "consul_server_asg_name" {
  value = "${module.consul.asg_name_servers}"
}

