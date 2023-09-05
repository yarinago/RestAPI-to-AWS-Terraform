variable "db_identifier" {
  description = "The RDS db uniqe idntifier that will be used in RDS resource"
  type        = string
  default = "rds-terraform"
}


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
  default = "postgresql"
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


variable "db_username" {
  description = "The RDS db username for login"
  type        = string
  default = "user"
}


variable "db_password" {
  description = "The RDS db password for login"
  type        = string
  default = "pass"
}