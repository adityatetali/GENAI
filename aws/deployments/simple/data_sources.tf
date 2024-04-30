data "aws_region" "current" {}

data "aws_vpc" "vpc" {
    id = local.vpc_id_core
}

data "aws_subnet" "private_subnet_primary" {
    id = local.subnet_primary_id
}

data "aws_subnet" "private_subnet_secondary" {
    id = local.subnet_secondary_id
}