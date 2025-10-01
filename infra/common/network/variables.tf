variable "region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = ""
}

####################################
# VPC Configuration
####################################

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "cluster_name" {
  type    = string
  default = "my-cluster"
}

####################################
# Subnet Configuration
####################################
variable "subnet_names" {
  type    = list(string)
  default = ["public-a", "application-a", "application-b", "database-a", "database-b"]
}

variable "subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "subnet_azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1a", "us-east-1b", "us-east-1a", "us-east-1b"]
}

variable "public_route_table_name" {
  type    = string
  default = ""
}

variable "private_route_table_name" {
  type    = string
  default = ""
}


variable "public_rt_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "private_rt_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "public_subnet_indexes" {
  type    = list(number)
  default = [0]
}

####################################
# NACL & NAT Gateway
####################################
variable "create_nacl" {
  type    = bool
  default = false
}


variable "nacl_names" {
  type    = list(string)
  default = []
}

variable "nacl_rules" {
  type    = any
  default = {}
}

variable "create_nat_gateway" {
  type    = bool
  default = false
}

################## key pair ################3333

variable "create_key_pair" {
  description = "Whether to create a key pair"
  type        = bool
  default     = false
}

variable "create_private_key" {
  description = "Whether to generate a private key using TLS"
  type        = bool
  default     = false
}

variable "key_pair_name" {
  description = "Name of the key pair"
  type        = string
  default     = "default-key"
}

variable "private_key_algorithm" {
  description = "Algorithm to use for TLS private key"
  type        = string
  default     = "RSA"
}

variable "private_key_rsa_bits" {
  description = "Number of bits for RSA key"
  type        = number
  default     = 4096
}

variable "public_key_path" {
  description = "Path to the public key file if not generating a key"
  type        = string
  default     = ""
}

variable "key_output_dir" {
  type    = string
  default = "./keys"
}

####################################
# Naming Convention
####################################
variable "env" {
  type    = string
  default = "d"
}

variable "bu" {
  type    = string
  default = "ot"
}

variable "app" {
  type    = string
  default = "bp"
}

variable "resource" {
  type    = string
  default = "instance"
}

variable "tenant" {
  type    = string
  default = ""
}

variable "enabled_features" {
  type    = list(string)
  default = []
}

variable "random_alphanumeric_len" {
  type    = number
  default = 4
}

variable "special" {
  type    = bool
  default = false
}

variable "upper" {
  type    = bool
  default = false
}

variable "number" {
  type    = bool
  default = true
}

variable "gen_no_of_names" {
  type    = number
  default = 1
}

####################################
# Tags & Metadata
####################################

variable "team" {
  type    = string
  default = "infra"
}

variable "program" {
  type    = string
  default = "ot"
}


variable "provisioner" {
  type    = string
  default = "terraform"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "create_nlb" {
  type    = bool
  default = false
}

variable "create_alb" {
  type    = bool
  default = false
}

variable "create_route53" {
  type        = bool
  description = "Enable Route53 private zone"
  default     = false
}
