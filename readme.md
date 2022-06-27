Author: Fredrick Jack
Date: 6/24/2022

This use cases' purpose is to demonstrate my ability to deploy a custom infrastructure using Terraform. It took into consideration the following requests:

The client requested to deploy and manage 3 env dev, test, and prod(3 AWS Accounts) with terraform.

you need to create a terraform project that will create the below actions.

External Team already build VPC, public and private subnets. The team didn’t provide access to the previous state. I should be able to read the values necessary to create the below resources.

1. S3 Bucket with SSE Enabled.

2. RDS Security Group

3. MySQL RDS in a Private subnet

4. EC2 Security Group

5. EC2 in a Private Subnet

6. EC2 should be able to talk to MySQL

7. ALB that uses ACM for TLS certs.

8. EC2 should only allow traffic from ACM.

9. ELB should only allow access from your IP.

In the root module you will find the following files:
main.tf - This file declares the required provider/version. It also references all child modules.

providers-main.tf - This file contains the provider blocks for the default account, as well as the child accounts (dev,test,prod). As a prerequisite, a subdirectory called .aws, and a file called credentials must be created. This is where you will store the Access Keys/Secret Access Keys that correspond to the respective profiles. For this to function properly, there would need to be a local execution block that populates this file with input variables. This has not been created for this example use case.

legacy_network.tf - This file will query the existing vpc and subnets that are referenced in the Use Case objectives, so that the same configuration may be used across the child accounts.

variables.tf - Input variables file. See file for descriptions. To achieve CI/CD, there will need to be a .tfvars file generated with values for the input variables that do not have a default listed.

I have created a root module, as well as four child modules that will meet this goals. The root module will reference the following child modules:

org- this module creates an AWS Organization, an Organizational Unit, and three Organizational Accounts. It also creates a role in each acccount for which Terraform can assume.

dev, test, prod - These modules create the resources requested by the client in their respective accounts.