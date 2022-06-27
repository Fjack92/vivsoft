terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}

## Module to create organizational accounts
module "org" {
    source = "./modules/org"
    org_name = var.org_name
    dev_email = var.dev_email
    test_email = var.test_email
    prod_email = var.prod_email
}

## Dev Resources
module "dev" {
  source = "./modules/dev"
  vpc_cidr = data.legacy_vpc.cidr
  private_subnet_cidr = data.legacy_private_subnet.cidr
  public_subnet_cidr = data.legacy_public_subnet.cidr
  rds_username = var.rds_username
  rds_password = var.rds_password

  providers = {
    aws = "aws.dev"
   }

  depends_on = [
      module.org
   ]
}

## Test Resources
module "test" {
  source = "./modules/test"
  vpc_cidr = data.legacy_vpc.cidr
  private_subnet_cidr = data.legacy_private_subnet.cidr
  public_subnet_cidr = data.legacy_public_subnet.cidr
  rds_username = var.rds_username
  rds_password = var.rds_password

  providers = {
    aws = "aws.test"
  }

  depends_on = [
      module.org
   ]
}

## Prod Resources
module "prod" {
  source = "./modules/prod"
  vpc_cidr = data.legacy_vpc.cidr
  private_subnet_cidr = data.legacy_private_subnet.cidr
  public_subnet_cidr = data.legacy_public_subnet.cidr
  rds_username = var.rds_username
  rds_password = var.rds_password

  providers = {
    aws = "aws.prod"
  }

  depends_on = [
      module.org
   ]
}