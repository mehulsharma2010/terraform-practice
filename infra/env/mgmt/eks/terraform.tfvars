
region = "us-east-2"
name   = "rems-olly"

# bucket configuration
bucket_region      = "ap-south-1"
bucket             = "ot-terraform-state-bucket"
network_bucket_key = "infra/common/network/terraform.tfstate"

create_iam_role            = true
create_node_iam_role       = true
create_security_group      = true
create_node_security_group = true

# Enable private-only API access
endpoint_private_access      = true
endpoint_public_access       = true
endpoint_public_access_cidrs = ["152.59.120.49/32"]

cluster_tags = {
  name        = "rems-eks-cluster-mgmt"
  environment = "mgmt"
  team        = "infra"
  application = "rems"
}


addons = {
  vpc-cni = {
    name                        = "vpc-cni"
    before_compute              = true
    resolve_conflicts_on_update = "OVERWRITE"
    resolve_conflicts_on_create = "OVERWRITE"
    most_recent                 = true
    tags = {
      Environment = "mgmt"
      Team        = "infra"
    }
  }

  coredns = {
    name                        = "coredns"
    resolve_conflicts_on_update = "OVERWRITE"
    resolve_conflicts_on_create = "OVERWRITE"
    most_recent                 = true
    tags = {
      Environment = "mgmt"
      Team        = "infra"
    }
  }

  kube-proxy = {
    name                        = "kube-proxy"
    before_compute              = true
    resolve_conflicts_on_update = "OVERWRITE"
    resolve_conflicts_on_create = "OVERWRITE"
    most_recent                 = true
    tags = {
      Environment = "mgmt"
      Team        = "infra"
    }
  }

  metrics-server = {
    name                        = "metrics-server"
    resolve_conflicts_on_update = "OVERWRITE"
    resolve_conflicts_on_create = "OVERWRITE"
    most_recent                 = true
    tags = {
      Environment = "mgmt"
      Team        = "infra"
    }
  }

  aws-ebs-csi-driver = {
    name                        = "aws-ebs-csi-driver"
    resolve_conflicts_on_update = "OVERWRITE"
    resolve_conflicts_on_create = "OVERWRITE"
    most_recent                 = true
    tags = {
      Environment = "mgmt"
      Team        = "infra"
    }
  }

  eks-pod-identity-agent = {
    name                        = "eks-pod-identity-agent"
    resolve_conflicts_on_update = "OVERWRITE"
    resolve_conflicts_on_create = "OVERWRITE"
    most_recent                 = true
    tags = {
      Environment = "mgmt"
      Team        = "infra"
    }
  }
}

addons_timeouts = {
  create = "15m"
  update = "15m"
  delete = "15m"
}
enable_alb_controller = true

enable_auto_mode_custom_tags = true

node_security_group_name = "rems-eks-node-sg-mgmt"
node_security_group_tags = {
  name        = "rems-eks-node-sg-mgmt"
  environment = "mgmt"
  team        = "infra"
  application = "rems"  
}
enable_cluster_creator_admin_permissions = true
access_entries = {
  eks_admin = {
    principal_arn = "arn:aws:iam::017820699516:user/opstree"
    policy_associations = {
      admin = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  }
}

eks_managed_node_groups = {
  olly = {
    create             = true
    kubernetes_version = "1.33"
    name               = "olly"
    # subnet_ids                   = []
    ami_type                   = "AL2023_x86_64_STANDARD"
    instance_types             = ["t3.medium"]
    desired_size               = 2
    min_size                   = 2
    max_size                   = 4
    capacity_type              = "SPOT"
    key_name                   = "ot-rems-key"
    create_launch_template     = true
    use_custom_launch_template = false
    launch_template_name       = "olly-template"
    launch_template_tags = {
      Environment = "mgmt",
      Owner       = "DevOps"
    }

    disk_size                    = 20
    iam_role_additional_policies = {}
    tags = {
      Name        = "olly-node"
      type        = "spot"
      Environment = "mgmt"
      Team        = "infra"
    }
  }

  rems-node = {
    create             = true
    kubernetes_version = "1.33"
    name               = "rems"
    # subnet_ids                  = []
    ami_type                    = "AL2023_x86_64_STANDARD"
    instance_types              = ["t3.medium"]
    desired_size                = 1
    min_size                    = 1
    max_size                    = 2
    capacity_type               = "SPOT"
    key_name                    = "ot-rems-key"
    create_launch_template      = true
    use_custom_launch_template  = false
    launch_template_name        = "rems-template"
    launch_template_description = null
    launch_template_tags        = {}
    tag_specifications          = []


    disk_size = 20
    iam_role_additional_policies = {
      EKSWorkerPolicy  = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      ECRReadOnly      = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
      EKSCNIPolicy     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      S3ReadOnlyAccess = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
      CWAgent          = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    }
    tags = {
      Name        = "rems-node"
      type        = "spot"
      Environment = "mgmt"
      Team        = "infra"
    }

  }

}



key_name        = "ot-rems-key"
create_key_pair = false
public_key_path = "/Users/mehulsharma/.ssh/id_rsa.pub"
