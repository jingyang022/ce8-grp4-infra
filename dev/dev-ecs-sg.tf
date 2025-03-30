# Security Group for dev ECS service
resource "aws_security_group" "dev-ecs-sg" {
  name_prefix = "ce8-grp4-dev-ecs-sg" #dev ECS Security group name
  description = "Security group for dev ECS service"
  # vpc_id      = data.aws_vpc.selected.id
  vpc_id = module.dev-vpc.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_5001" {
  security_group_id = aws_security_group.dev-ecs-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5001
  ip_protocol       = "tcp"
  to_port           = 5001
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_5001" {
  security_group_id = aws_security_group.dev-ecs-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
