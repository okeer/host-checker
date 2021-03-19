variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::828162785311:root"
      username = "okeer"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::828162785311:user/circle_ci"
      username = "circleci"
      groups   = ["system:masters"]
    },
  ]
}