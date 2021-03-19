resource "aws_iam_role" "cluster_role" {
  name = "${terraform.workspace}-playground-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.assume_cluster_role.json
}

resource "aws_iam_policy" "cluster_policy" {
  policy = data.aws_iam_policy_document.cluster_policy.json
}

resource "aws_iam_role_policy_attachment" "cluster_policy_attachment" {
  policy_arn = aws_iam_policy.cluster_policy.arn
  role = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  policy_arn = data.aws_iam_policy.eks_policy.arn
  role = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_policy_attachment" {
  policy_arn = data.aws_iam_policy.eks_vpc_policy.arn
  role = aws_iam_role.cluster_role.name
}

resource "aws_iam_role" "pod_execution_role" {
  name = "${terraform.workspace}-playground-pod-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_cluster_role.json
}

resource "aws_iam_role_policy_attachment" "pod_exec_policy_attachment" {
  policy_arn = data.aws_iam_policy.pod_execution_policy.arn
  role = aws_iam_role.pod_execution_role.name
}
