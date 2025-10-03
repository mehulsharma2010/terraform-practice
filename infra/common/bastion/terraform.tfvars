ami_ssm_parameter = ""
region            = "ap-south-1"
# availability_zone = "ap-south-1a"
create_eip      = true
ebs_optimized   = true
instance_type   = "t3.micro"
key_name        = "ot-key"
create_key_pair = true
public_key_path = "/Users/mehulsharma/.ssh/id_rsa.pub"

create_security_group          = true
security_group_use_name_prefix = true
security_group_name            = "bastion-sg"
security_group_description     = "Bastion EC2 Security Group"
associate_public_ip_address    = true
vpc_security_group_ids         = []

ec2_security_group_tags = {
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
  volume_size           = 50
  volume_type           = "gp3"
  delete_on_termination = true
}
