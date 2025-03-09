output "vpc_id" {
  # value = data.aws_vpc.selected.id
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = data.aws_subnets.public.ids
}