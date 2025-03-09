/*
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["ce8-grp4-vpc"]
  }
}*/

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_subnets" "public" {
  /*filter {
    name = "vpc-id"
    #values = [var.vpc_id]
    values = [module.vpc-1.vpc_id]
  }*/

  filter {
    name   = "tag:Name"
    values = ["ce8-grp4-vpc-public-*"]
  }
  depends_on = [module.vpc]
}

/*
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "tag:Name"
    # values = ["*public-*"]
    values = ["ce8-grp4-public-*"]
  }
}*/
