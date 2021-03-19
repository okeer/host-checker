resource "aws_eks_fargate_profile" "default" {
  cluster_name = "${terraform.workspace}-playground"
  fargate_profile_name = "${terraform.workspace}-playground"
  pod_execution_role_arn = aws_iam_role.pod_execution_role.arn

  selector {
    namespace = "default"
    labels = {}
  }

  selector {
    namespace = "kube-system"
    labels = {}
  }

  lifecycle {
    ignore_changes = ["subnet_ids"]
  }

  depends_on = [module.eks.cluster_endpoint]
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version = "14.0.0"

  cluster_name    = "${terraform.workspace}-playground"
  cluster_version = "1.19"
  subnets         = data.terraform_remote_state.vpc.outputs.private_subnets_ids
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id

  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  cluster_endpoint_private_access = true

  manage_cluster_iam_resources = false
  create_fargate_pod_execution_role = false

  cluster_iam_role_name = aws_iam_role.cluster_role.name

  map_users    = var.map_users

  depends_on = [aws_iam_role.cluster_role]
}
