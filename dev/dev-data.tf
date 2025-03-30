
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_subnets" "dev-vpc-public" {
  filter {
    name   = "tag:Name"
    values = ["ce8-grp4-dev-vpc-public-*"]
  }
  depends_on = [module.dev-vpc]
}
