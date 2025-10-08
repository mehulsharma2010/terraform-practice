################################################################################
# EC2 Instance Outputs
################################################################################

output "instance_id" {
  value       = module.ec2-instance.id
  description = "The ID of the EC2 instance"
}

output "instance_arn" {
  value       = module.ec2-instance.arn
  description = "The ARN of the EC2 instance"
}
################################################################################
# EBS Volume(s)
################################################################################

output "ebs_volumes_ids" {
  value       = module.ec2-instance.ebs_volumes
  description = "Map of EBS volumes and their attributes"
}

output "ami_id" {
  value       = module.ec2-instance.ami
  description = "The AMI ID used for the instance"
}

output "public_ip" {
  value       = module.ec2-instance.public_ip
  description = "The public IP address assigned to the instance"
  
}

output "iam_role_arn" {
  value       = module.ec2-instance.iam_role_arn
  description = "The ARN of the IAM role associated with the instance"
}

output "security_group_id" {
  description = "Primary security group ID of the EC2 instance"
  value       = try(module.ec2-instance.security_group_id, null)
}




