Subnets
Security Groups
Network ACLs
Internet Gateways
Egress Only Internet Gateways
Route Tables
Network Interfaces
Peering Connections
Endpoints

You need to create the network with the following order

- VPC
    With the creation of VPC AWS automatically create 
        DHCP Options Sets
        Main Route Table
        Main Network ACL
        

- Subnets
  - Private
  - Public

- Create route tables
  - Private (main)
  - Public

- Create an internet gateway associatted with the VPC
- create a elastic IP it's necessary for the NAT gateway
- Create a NAT gateway

- Associate the private route table as the main table
- Associate the main route table of the VPC with the NAT gateway created

- Associte the public route table with the IGW

- Associate the public route table with the public Subnet
- Associate the private route table with the private Subnet


- Launch the instances
  - public
  - private


TODO
Add provisioners and test the installation of NGINX in the remote mahcines
