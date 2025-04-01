# Create dev ECR repo to store image
resource "aws_ecr_repository" "dev-repo" {
  name         = "ce8-grp4-dev-repo"
  force_delete = true
}

# Create dev ECS cluster and service
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"

  cluster_name = "ce8-grp4-dev-cluster"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    ce8-grp4-dev-ecs = {
      cpu    = 512
      memory = 1024

      container_definitions = {
        ce8-grp4-dev-app = {
          essential = true
          image     = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/ce8-grp4-dev-repo:latest"
          port_mappings = [
            {
              containerPort = 5001
              hostPort      = 5001
              protocol      = "tcp"
            }
          ]
          environment = [
            {
              name  = "AWS_REGION"
              value = "ap-southeast-1"
            },
            {
              name  = "BUCKET_NAME"
              value = "ce8-grp4-dev-bucket"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      create_tasks_iam_role              = false
      tasks_iam_role_arn                 = aws_iam_role.dev_ecs_task_role.arn
      subnet_ids                         = data.aws_subnets.dev-vpc-public.ids
      security_group_ids                 = [aws_security_group.dev-ecs-sg.id] #Create a SG resource and pass it here
    }
  }
}

# Create dev ECS task role
resource "aws_iam_role" "dev_ecs_task_role" {
  name = "ce8-grp4-dev-ecs-taskrole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dev_ecs_task_attachment" {
  role       = aws_iam_role.dev_ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

