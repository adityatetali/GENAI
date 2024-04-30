variable "vpc_name" {
  default = "Bedrock-VPC"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b"]
}

variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "allowed_ips" {
  type = list(string)
  default = [ "1.2.3.4/32", "2.3.4.5/32" ]
}