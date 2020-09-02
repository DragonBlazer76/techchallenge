provider "aws" {
  version = "~> 2.0"
  region  = "ap-southeast-1" # Setting my region to Singapore.
}

resource "aws_ecr_repository" "techchallenge_ecr_repo" {
  name = "techchallenge-ecr-repo" # Naming my repository
}

resource "aws_ecs_cluster" "techchallenge_cluster" {
  name = "techchallenge-cluster" # Naming the cluster
}

resource "aws_ecs_task_definition" "my_first_task" {
  family                   = "techchallenge-task" # Naming first task
  container_definitions    = <<DEFINITION
  [
    {
      "name": "techchallenge-task",
      "image": "${aws_ecr_repository.techchallenge_ecr_repo.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}