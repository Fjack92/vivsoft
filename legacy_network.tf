## Query Data for existing VPC
data "aws_vpc" "legacy_vpc" {
  filter {
    name = var.legacy_vpc_name
  }
}

## Query Data for existing subnets
data "aws_subnet" "legacy_private_subnet" {
  filter {
      name = var.legacy_private_subnet_name
  }
}

data "aws_subnet" "legacy_public_subnet" {
  filter {
      name = var.legacy_public_subnet_name
  }
}