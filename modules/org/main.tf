resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "org_unit" {
  name = var.org_name
  parent_id = aws_organizations_organization.org.id
}

resource "aws_organizations_account" "dev" {
  name = "dev"
  email = var.dev_email
  parent_id = aws_organizations_organizational_unit.org_unit.id
  role_name = "Terraform-Admin"
}

resource "aws_organizations_account" "test" {
  name = "test"
  email = var.test_email
  parent_id = aws_organizations_organizational_unit.org_unit.id
  role_name = "Terraform-Admin"
}

resource "aws_organizations_account" "prod" {
  name = "prod"
  email = var.prod_email
  parent_id = aws_organizations_organizational_unit.org_unit.id
  role_name = "Terraform-Admin"
}