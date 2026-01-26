# Terraform Outputs
# These outputs provide important information after infrastructure deployment

output "web_server_eip" {
  description = "Elastic IP address of the web server (use this for DNS A record)"
  value       = aws_eip.web_eip.public_ip
}

output "web_server_private_ip" {
  description = "Private IP address of the web server"
  value       = aws_instance.web_server.private_ip
}

output "web_server_instance_id" {
  description = "Instance ID of the web server"
  value       = aws_instance.web_server.id
}

output "ansible_controller_private_ip" {
  description = "Private IP address of the Ansible controller"
  value       = aws_instance.ansible_controller.private_ip
}

output "ansible_controller_instance_id" {
  description = "Instance ID of the Ansible controller"
  value       = aws_instance.ansible_controller.id
}

output "monitoring_server_private_ip" {
  description = "Private IP address of the monitoring server"
  value       = aws_instance.monitoring_server.private_ip
}

output "monitoring_server_instance_id" {
  description = "Instance ID of the monitoring server (for SSM access)"
  value       = aws_instance.monitoring_server.id
}

output "ecr_repository_uri" {
  description = "URI of the ECR repository"
  value       = aws_ecr_repository.final_project.repository_url
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.devops_vpc.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = aws_subnet.private_subnet.id
}
