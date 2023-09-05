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