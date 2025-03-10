
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["ce8-grp4-vpc-public-*"]
  }
  depends_on = [module.vpc]
}
