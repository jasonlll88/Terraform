# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.eks-vpc.vpc_id}"
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = "${module.eks-vpc.private_subnets}"
}

/* # EKS - endpoint
output "endpoint" {
  value = "${aws_eks_cluster.eks-cluster.endpoint}"
}

# EKS - certificate authority
output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks-cluster.certificate_authority.0.data}"
} */