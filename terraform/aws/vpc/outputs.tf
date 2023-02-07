#### OUTPUTS #####

output "networks" {
  description = "List of calculated networks to be used"
  value       = module.calcsubnets.network_cidr_blocks
}


output "availableazs_names" {
  description = "List of availalbe azs in the region"
  value       = data.aws_availability_zones.availableazs.names

}

output "availableazs_ids" {
  description = "List of availalbe azs in the region"
  value       = data.aws_availability_zones.availableazs.zone_ids
}

#output "private_subnets_ids" {
#  description = "list of ids of private subnets"
#  value = module.vpc.private_subnets
#}

#output "private_subnets_cidrs" {
#  description = "list of ids of private subnets"
#  value = module.vpc.private_subnets_cidr_blocks
#}

#output "private_ngw_ids" {
#  description = "list of ids of private subnets"
#  value = module.vpc.private_nat_gateway_route_ids
#}

output "vpc_outputs" {
  description = "All Outputs from the VPC module"
  value       = module.vpc
}