locals {
  vpc_tags = {
    Terraform   = "true"
    Environment = var.environment
  }
  db_secret = jsondecode(data.aws_secretsmanager_secret_version.secret_credentials.secret_string)
}

#resource "aws_eip" "nat" {
#  count = 2
#
#  vpc = true
#}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "${var.environment}-${var.project_name}-vpc"
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway
  reuse_nat_ips = true # Skip creation of EIPs for the NAT Gateways
  #external_nat_ip_ids = "${aws_eip.nat.*.id}" # IPs specified here as input to the module

  tags = local.vpc_tags
}


# Fetch the secret data (from AWS secret manager)
data "aws_secretsmanager_secret" "db_credentials" {
 name = "${var.environment}_rds_dbCredentials"
}

# Used to read the data of the secret (from AWS secret manager)
data "aws_secretsmanager_secret_version" "secret_credentials" {
 secret_id = data.aws_secretsmanager_secret.db_credentials.id
}

resource "aws_db_instance" "rds_instance" {
    allocated_storage = var.db_allocated_storage
    identifier = "${var.environment}-${var.project_name}-rds"
    storage_type = var.db_storage_type
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    username = local.db_secret["db_username"]
    password = local.db_secret["db_password"]
    publicly_accessible = false 
    skip_final_snapshot = true # Disable taking a final backup when you destroy the database
     

    tags = {
        Name = "SampleRestApiRDSInstance"
        }
}



resource "aws_ecr_repository" "ecr" {
  name = "${var.environment}-${var.repository_name}"
  image_tag_mutability = var.image_mutability
  tags = local.vpc_tags
}



resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.environment}-${var.project_name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "task_definition" {
  family             = var.ecs_image_name
  #execution_role_arn = "arn:aws:iam::${local.aws_account_id}:role/ecsTaskExecutionRole"
  memory             = var.task_definition_memory
  cpu                = var.task_definition_cpu
  container_definitions = jsonencode([
    {
      name      = var.ecs_image_name
      image     = "${var.ACCOUNT_ID}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecs_image_name}:latest"
      essential = true # Is it an essential container and its failure means that every other task will stop
      portMappings = var.portMappings
    }
  ])
  tags = {
    ProjectName = var.project_name
    Environment = var.environment
    AssociatedCluster = aws_ecs_cluster.ecs-cluster.name
  }
}

resource "aws_ecs_service" "flask_container" {
  name = var.ecs_image_name
  cluster = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task_definition.id
  desired_count = var.desired_conatiners_count
}