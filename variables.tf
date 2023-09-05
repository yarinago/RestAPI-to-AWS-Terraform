################## AWS CONFIGURATION ##################

variable "aws_region" {
  default = "eu-central-1"
}

variable "ACCESS_KEY_ID" {
  description = "The AWS acces key"
  type = string
}

variable "SECRET_ACCESS_KEY" {
  description = "The AWS secret that match the access key"
  type = string
}

variable "ACCOUNT_ID" {
  description = "The AWS account id"
  type = string
}

variable "environment" {
  description = "Name of environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of entire project"
  type        = string
  default     = "sample-rest-api"
}


################## VPC ##################

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}


################## RDS ##################

variable "db_allocated_storage" {
  description = "The RDS db storage to be allocated for the RDS db in Gib"
  type        = number
  default = 20
}

variable "db_storage_type" {
  description = "The RDS db storage type that will be used in RDS resource"
  type        = string
  default = "gp2"
}

variable "db_engine" {
  description = "The RDS db engine type that will be used in RDS resource"
  type        = string
  default = "postgres"
}

variable "db_engine_version" {
  description = "The RDS db engine version that will be used in RDS resource"
  type        = string
  default = "13.7"
}

variable "db_instance_class" {
  description = "The RDS db instance class type that will be used in RDS resource"
  type        = string
  default = "db.t3.micro"
} 

################## ECR ##################

variable "repository_name" {
  description = "The ECR repository name that will be used in ecr resource"
  type        = string
  default = "flask_images_repo"
}

variable "image_mutability" {
  description = "MUTABLE - image tags can be overwritten. IMMUTABLE - prevent all image tags within the repository from being overwritten"
  type        = string
  default = "MUTABLE"
}

################## ECS ##################

variable "ecs_name" {
  description = "The ECR repository name that will be used in ecr resource"
  type        = string
  default = "flask_images_repo"
}

variable "ecs_image_name" {
  description = "The name of the image that will be taken from ECR"
  type        = string
  default = "flask_images_repo"
}

variable "task_definition_memory" {
  description = "The amount of memory to allocate to the task"
  type        = number
  default = 512 # Equal to 0.5GB
}

variable "task_definition_cpu" {
  description = "The amount of cpu to allocate to the task"
  type        = number
  default = 256 # Equal to 0.25vCPU
}

variable "desired_conatiners_count" {
  description = "The number of container to create in the ECS cluster"
  type        = number
  default = 1
}

variable "portMappings" {
  type = list(object({
    containerPort = number
    hostPort = number
  }))
  default = [
    {
      containerPort = 80
      hostPort      = 80
    }
  ]
}