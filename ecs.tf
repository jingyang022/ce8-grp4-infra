# Create two ECR repo for S3 and SQS services

resource "aws_ecr_repository" "flask-s3-repo" {
  name         = "ce8-grp4-flask-s3-repo"
  force_delete = true
}

# Create ECS cluster and service
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"

  cluster_name = "ce8-grp4-cluster"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    ce8-grp4-s3-service = {
      cpu    = 512
      memory = 1024

      container_definitions = {
        ce8-grp4-s3-app = {
          essential = true
          image     = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/ce8-grp4-flask-s3-repo:latest"
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
              value = "ce8-grp4-bucket"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      create_tasks_iam_role              = false
      tasks_iam_role_arn                 = aws_iam_role.ecs_task_role.arn
      subnet_ids                         = data.aws_subnets.public.ids
      security_group_ids                 = [aws_security_group.ecs-s3-sg.id] #Create a SG resource and pass it here
    }
  }
}

