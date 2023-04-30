resource "aws_ecs_cluster" "prod" {
  name = "prod-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "prod" {
  cluster_name = aws_ecs_cluster.prod.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}