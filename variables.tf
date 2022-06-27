variable "aws_region" {
  type = string
  description = "Region that you want to deploy AWS resources to"
}

variable "org_name" {
  type = string
  description = "Organization's name"
}

variable "dev_email" {
  type = string
  description = "Email address to register dev account"
}

variable "test_email" {
  type = string
  description = "Email address to register test account"
}

variable "prod_email" {
  type = string
  description = "Email address to register prod account"
}

variable "legacy_vpc_name" {
  type = string
  description = "Name of the pre-existing VPC that you would like to model for the sub-accounts"
}

variable "legacy_private_subnet_name" {
  type = string
  description = "Name of the pre-existing private subnet that you would like to model for the sub-accounts"
  
}

variable "legacy_public_subnet_name" {
  type = string
  description = "Name of the pre-existing public subnet that you would like to model for the sub-accounts"
}

variable "rds_username" {
  type = string
  Description = "Username for MYSQL rds instance"
  default = "admin"
}

variable "rds_password" {
  type = string
  Description = "Password for MYSQL rds instance"
  default = "password"
}