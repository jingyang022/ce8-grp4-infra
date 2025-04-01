module "dev-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"
  name    = "ce8-grp4-dev-vpc"

  cidr = "10.2.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
  #private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = false # set to false if no private subnet
  single_nat_gateway   = false
  enable_dns_hostnames = true # needed for DNS resolution
  map_public_ip_on_launch = true
}