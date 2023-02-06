locals {

  region = "us-east-1"

  vpc_name   = "ekstesting"
  cidr       = "198.10.0.0/16"
  vpc_create = "true"

  common_tags = {
    Managedby = "Terraform"
    For       = "Networking"
  }

  private_subnet_tags = {
    Type = "private"
  }

  public_subnet_tags = {
    Type = "public"
  }

  intra_subnet_tags = {
    Type = "eks-cplane"
  }

}

#data "aws_region" "current" {}

# This module wraps cidrsubnets to give more functionality, like building a map with each subnet
# https://registry.terraform.io/modules/hashicorp/subnets/cidr/latest
module "calcsubnets" {
  source  = "hashicorp/subnets/cidr"
  version = "1.0.0"
  # insert the 2 required variables here

  base_cidr_block = local.cidr

  networks = [
    {
      name     = "public-az1"
      new_bits = 4
    },
    {
      name     = "public-az2"
      new_bits = 4
    },
    {
      name     = "public-az3"
      new_bits = 4
    },
    {
      name     = "private-az1"
      new_bits = 4
    },
    {
      name     = "private-az2"
      new_bits = 4
    },
    {
      name     = "private-az3"
      new_bits = 4
    },
    {
      name     = "private-ekscplan-az1"
      new_bits = 12
    },
    {
      name     = "private-ekscplan-az2"
      new_bits = 12
    }
  ]
}

# Get Azs information
data "aws_availability_zones" "availableazs" {
  state = "available"
}


module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  #Enable VPC creation
  create_vpc = local.vpc_create

  # Name and global CIDR
  name = local.vpc_name
  cidr = local.cidr


  # Az's and subnet CIDR's to be used VPC creation
  azs             = slice(data.aws_availability_zones.availableazs.names, 0, 3)
  private_subnets = [module.calcsubnets.network_cidr_blocks["private-az1"], module.calcsubnets.network_cidr_blocks["private-az2"], module.calcsubnets.network_cidr_blocks["private-az3"]]
  public_subnets  = [module.calcsubnets.network_cidr_blocks["public-az1"], module.calcsubnets.network_cidr_blocks["public-az2"], module.calcsubnets.network_cidr_blocks["public-az3"]]
  intra_subnets   = [module.calcsubnets.network_cidr_blocks["private-ekscplan-az1"], module.calcsubnets.network_cidr_blocks["private-ekscplan-az2"]]

  # Extra Tagging of Subnets
  private_subnet_tags = local.private_subnet_tags
  public_subnet_tags  = local.public_subnet_tags
  intra_subnet_tags   = local.intra_subnet_tags

  # Enable DNS hostnames and support, it's a requirement of many AWS services like EKS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enable Nat Gateway for internet route for private subnets
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = local.common_tags

}