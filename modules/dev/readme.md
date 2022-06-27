This module deploys the requested resources. Below is a summary of each file.

network.tf - creates vpc and subnet, modeled after the pre-existing resources that were in the root account.

ec2.tf - creates security group that only allows incoming traffic from within the vpc. Ports are limited to MYSQL and load balancer ports. also declares instance with latest ubuntu 20.04 AMI. Instance is deployed in private subnet.

rds.tf - creates db security group, as well as rds instance. RDS instance is deployed in private subnet.

cert.tf - Declares resources pertaining to the ACM cert needed for the application load balancer. Uses TLS as requested.

load_balancer - Creates s3 bucket for access logs, and security group limiting access to my personal ip address on ports 80, and 443.

variables.tf - list of input variables. these are all passed in from the module block in the root module's main.tf.