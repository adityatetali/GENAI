module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "bedrock_sg" {
  name        = var.sg_name
  description = "Control network access for Bedrock"
  vpc_id      = module.vpc.vpc_id 
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.bedrock_sg.id
  type              = "ingress"
  from_port         =  0
  to_port           =  65535
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ips 
}