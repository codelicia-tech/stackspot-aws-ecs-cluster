
module "service" {
  source = "./modules/ecs_service"
  name   = "{{app_name}}"
  container_name = "{{app_name}}"
  cluster = module.prod.ecs_cluster
  subnet_id1 = module.prod.private_subnet_id
  subnet_id2 = module.prod.private_subnet_id2
  vpc_id = module.prod.vpc_id
  # target_group_arn = module.prod.target_group_arn
  image = "{{aws_account_id}}.dkr.ecr.us-east-1.amazonaws.com/{{org_name}}-{{app_name}}:latest"
  cpu   = 2048
  memory = 5120
  container_port = {{port}}
  health_check_path = "{{health_check_path}}"
}

resource "aws_lb_listener" "prod" {
  load_balancer_arn = module.prod.alb_arn
  port              = {{port}}
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.service.target_group_arn
    type             = "forward"
  }
}