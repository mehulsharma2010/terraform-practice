##############################
# VPC
##############################
region               = "ap-south-1"
vpc_cidr             = "10.0.0.0/16"
instance_tenancy     = "default"
enable_dns_support   = false
enable_dns_hostnames = false
cluster_name         = "observability-rems"

##############################
# Subnets
##############################
subnet_names = ["olly-rems-public-1", "olly-rems-public-2", "olly-rems-private-1", "olly-rems-private-2"]
subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
subnet_azs   = ["ap-south-1a", "ap-south-1b", "ap-south-1a", "ap-south-1b"]

public_route_table_name  = "olly-rems-public-rt"
private_route_table_name = "olly-rems-private-rt"

# Use indexes for both public subnets
public_subnet_indexes = [0]

##############################
# NAT Gateway
##############################
create_nat_gateway = true

##############################
# NACL Configuration
##############################
create_nacl = false
random_alphanumeric_len = 4

bu       = "ot"
app      = "rems"
env      = "g"
resource = "network"
tenant   = "rems"

special = false
upper   = false
number  = true

gen_no_of_names = 1

create_route53 = false
create_alb     = false
create_nlb     = false

##############################
# Key Pair Configuration
##############################

create_key_pair    = true
create_private_key = false
key_pair_name      = "ot-rems-key"
public_key_path    = "/Users/mehulsharma/.ssh/id_rsa.pub" # Leave blank if you're generating the key
