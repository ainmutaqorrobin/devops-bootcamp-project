# Main Terraform configuration file
# Infrastructure resources have been organized into separate files:
# - vpc.tf: VPC, subnets, gateways
# - routing.tf: Route tables and associations
# - ecr.tf: Container registry
# - ec2.tf: EC2 instances and IAM roles
# - security-groups.tf: Security groups