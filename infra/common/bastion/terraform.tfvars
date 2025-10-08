ami_ssm_parameter = ""
region            = "us-east-2"
ami               = ""
create_eip        = true
ebs_optimized     = true
instance_type     = "t2.micro"
key_name          = "rems-key"
create_key_pair   = false
public_key_path   = "/home/anjalidhiman/.ssh/id_ed25519.pub"


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
