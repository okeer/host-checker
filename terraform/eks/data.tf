data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "okeer-eks-state"
    key     = "terraform/vpc.tfstate"
    region  = "eu-central-1"
    profile = "sorlov"
  }

  workspace = terraform.workspace
}

data "aws_region" "_" {}

data "aws_caller_identity" "_" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_iam_policy" "eks_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

data "aws_iam_policy" "eks_vpc_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

data "aws_iam_policy" "pod_execution_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}