output "dev_account_id" {
  value = aws_organizations_account.dev.id
}

output "test_account_id" {
  value = aws_organizations_account.test.id
}

output "prod_account_id" {
  value = aws_organizations_account.prod.id
}