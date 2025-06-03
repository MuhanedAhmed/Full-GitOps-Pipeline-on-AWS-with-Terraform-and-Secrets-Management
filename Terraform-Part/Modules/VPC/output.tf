# -------------------------------------------------------------- #
# --------------------- VPC Module Outputs --------------------- #
# -------------------------------------------------------------- #

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.gp_vpc.id
}

output "public_subnet_IDs" {
  description = "A map of public subnet IDs"
  value       = { for k, v in aws_subnet.gp_public_subnets : k => v.id }
}

output "private_subnet_IDs" {
  description = "A map of private subnet IDs"
  value       = { for k, v in aws_subnet.gp_private_subnets : k => v.id }
}