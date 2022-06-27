variable "vpc_cidr" {
  type = string
  Description = "CIDR block of VPC which we are modeling from root account"
}

variable "private_subnet_cidr" {
  type = string
  Description = "CIDR block of the private subnet which we are modeling from root account"
}

variable "public_subnet_cidr" {
  type = string
  Description = "CIDR block of the public subnet which we are modeling from root account"
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