data "aws_iam_policy_document" "cluster_policy" {
  statement {
    effect = "Allow"
    actions = ["ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeInternetGateways"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = ["cloudwatch:PutMetricData"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_cluster_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["eks.amazonaws.com",
        "eks-fargate-pods.amazonaws.com"]
      type = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}