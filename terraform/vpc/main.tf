locals {
  region = "eu-central-1"
  cidr = "10.0.0.0/16"
  ciders   = cidrsubnets(local.cidr, 8, 8, 8, 8)
  cluster_name = "${terraform.workspace}-playground"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = local.cluster_name
  cidr = local.cidr

  azs            = ["${local.region}a", "${local.region}b"]
  private_subnets = [local.ciders[0], local.ciders[1]]
  public_subnets = [local.ciders[2], local.ciders[3]]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
