ami_ssm_parameter = ""
region            = "ap-south-1"
ami               = "ami-0bfdc7eb9b5d564f5"
create_eip        = true
ebs_optimized     = true
instance_type     = "t3.medium"
key_name          = "ot-rems-key"
create_key_pair   = false
public_key_path   = "/home/mehulsharma/.ssh/id_rsa.pub"

create_security_group          = true
create_iam_instance_profile    = true
security_group_use_name_prefix = true
security_group_name            = "bastion-sg"
security_group_description     = "Bastion EC2 Security Group"
associate_public_ip_address    = true
vpc_security_group_ids         = []

security_group_tags = {
  Name = "bastion-sg"
}
security_group_ingress_rules = {
  ssh = {
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
    description = "Allow SSH"
  }

}

security_group_egress_rules = {
  all_ipv4 = {
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "-1"
    description = "Allow all outbound IPv4 traffic"
  }
}

tags = {
  Environment = "mgmt"
  Project     = "REMS"
  Name        = "bastion-host"
}

instance_tags = {
  Name = "Bastion"
}

ec2_name = "bastion-host"

root_block_device = {
  volume_size           = 30
  volume_type           = "gp3"
  delete_on_termination = true
}
