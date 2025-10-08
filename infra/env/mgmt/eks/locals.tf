locals {
  private_subnets = {
    for k, v in data.terraform_remote_state.network.outputs.subnet_ids :
    k => v if can(regex("private", k))
  }
}

locals {

  bastion_sg_id = data.terraform_remote_state.bastion.outputs.security_group_id
  node_sg_additional_rules = {

    allow_ssh_from_bastion = {
      protocol                    = "tcp"
      from_port                   = 22
      to_port                     = 22
      type                        = "ingress"
      description                 = "Allow SSH access to nodes from Bastion host"
      referenced_security_group_id = local.bastion_sg_id
    }

    allow_ssh_from_bastion = {
      protocol                    = "https"
      from_port                   = 443
      to_port                     = 443
      type                        = "ingress"
      description                 = "Allow SSH access to nodes from Bastion host"
      referenced_security_group_id = local.bastion_sg_id
    }

    #############################################
    # 2️⃣ Allow all internal traffic between nodes
    #############################################
    allow_all_internal = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      description = "Allow all internal traffic between cluster nodes"
      self        = true
    }

    #############################################
    # 3️⃣ Allow control plane to communicate with nodes
    #############################################
    allow_cluster_to_nodes = {
      protocol                      = "tcp"
      from_port                     = 1025
      to_port                       = 65535
      type                          = "ingress"
      description                   = "Allow control plane to communicate with nodes"
      source_cluster_security_group = true
    }

    #############################################
    # 4️⃣ Allow all outbound traffic from nodes
    #############################################
    allow_all_egress = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      description = "Allow all outbound traffic from nodes"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
