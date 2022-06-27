provider "aws" {
  shared_credentials_files = [ "./.aws/credentials" ]
  profile = "default"
  region = var.aws_region
}

provider "aws" {
  shared_credentials_files = [ "./.aws/credentials" ]
  profile = "dev"
  alias = "dev"

  assume_role {
    role_arn = "arn:aws:iam::${module.org.dev_account_id}:role/Terraform-Admin"
  }
}

provider "aws" {
  shared_credentials_files = [ "./.aws/credentials" ]
  profile = "test"
  alias = "test"

  assume_role {
    role_arn = "arn:aws:iam::${module.org.test_account_id}:role/Terraform-Admin"
  }
}

provider "aws" {
  shared_credentials_files = [ "./.aws/credentials"]
  profile = "prod"
  alias = "prod"

  assume_role {
    role_arn = "arn:aws:iam::${module.org.prod_account_id}:role/Terraform-Admin"
  }
}