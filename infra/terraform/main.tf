terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_ecs_cluster" "polyverse" {
  name = "polyverse-cluster"
}

resource "aws_ecs_service" "hub" {
  name            = "polyverse-hub"
  cluster         = aws_ecs_cluster.polyverse.id
  task_definition = aws_ecs_task_definition.hub.arn
  desired_count   = 3
}

resource "aws_ecs_task_definition" "hub" {
  family                   = "polyverse-hub"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  
  container_definitions = jsonencode([{
    name  = "hub"
    image = "polyverse/hub:latest"
    portMappings = [{
      containerPort = 8000
      protocol      = "tcp"
    }]
  }])
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

