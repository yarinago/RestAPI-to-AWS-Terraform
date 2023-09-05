#resource "aws_eip" "nat" {
#  count = 2
#
#  vpc = true
#}
#
#module "vpc" {
#  source  = "terraform-aws-modules/vpc/aws"
#  version = "5.1.0"
#
#  name = var.vpc_name
#  cidr = var.vpc_cidr
#
#  azs             = var.vpc_azs
#  private_subnets = var.vpc_private_subnets
#  public_subnets  = var.vpc_public_subnets
#
#  enable_nat_gateway = var.vpc_enable_nat_gateway
#  reuse_nat_ips = true # Skip creation of EIPs for the NAT Gateways
#  external_nat_ip_ids = "${aws_eip.nat.*.id}" # IPs specified here as input to the module
#
#  tags = var.vpc_tags
#}