# iam-policy.tf

resource "aws_iam_policy" "opstree-rems-terraform" {
  name        = "opstree-rems-terraform"
  description = "IAM policy for EC2 wrapper with EKS, IAM, EC2, ELB, Logs, and SSM access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeKeyPairs",
          "ec2:CreateSecurityGroup",
          "ec2:DeleteSecurityGroup",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:CreateTags",
          "ec2:DescribeSecurityGroupRules"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "autoscaling:CreateAutoScalingGroup",
          "autoscaling:UpdateAutoScalingGroup",
          "autoscaling:DeleteAutoScalingGroup",
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:CreateLaunchConfiguration",
          "autoscaling:DeleteLaunchConfiguration"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:DeleteLoadBalancer",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:CreateTargetGroup",
          "elasticloadbalancing:DeleteTargetGroup",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:TagResource",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:ListTagsForResource",
          "logs:PutRetentionPolicy",
          "logs:DeleteLogGroup",
          "logs:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "ssm:DescribeParameters"
        ]
        Resource = "*"
      }
    ]
  })
}
