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

- Create an internet gateway associatted with the VPC


- Associate the main route table of the VPC with the internet gateway created

- create a elastic IP it's necessary for the nat gateway

- create a Nat gateway



 To make your subnet a public subnet, you must attach an internet gateway to your VPC, You can then create a custom route table, and add route to the internet gateway

 Create or modify your security groups as needed.

 Create or modify your network ACLs as needed.

