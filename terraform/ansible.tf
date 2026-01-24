# Generate Ansible inventory file from Terraform outputs

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content = templatefile("${path.module}/inventory.tpl", {
    web_server_ip       = aws_eip.web_eip.public_ip
    ansible_controller_ip = aws_instance.ansible_controller.private_ip
    monitoring_server_ip = aws_instance.monitoring_server.private_ip
    web_server_instance_id = aws_instance.web_server.id
    ansible_controller_instance_id = aws_instance.ansible_controller.id
    monitoring_server_instance_id = aws_instance.monitoring_server.id
    ecr_repository_uri   = aws_ecr_repository.final_project.repository_url
  })

  depends_on = [
    aws_instance.web_server,
    aws_instance.ansible_controller,
    aws_instance.monitoring_server,
    aws_eip.web_eip,
  ]
}

# Outputs for Ansible inventory
output "web_server_public_ip" {
  description = "Public IP of the web server for Ansible inventory"
  value       = aws_eip.web_eip.public_ip
}

output "ansible_controller_private_ip" {
  description = "Private IP of the Ansible controller"
  value       = aws_instance.ansible_controller.private_ip
}

output "monitoring_server_private_ip" {
  description = "Private IP of the monitoring server"
  value       = aws_instance.monitoring_server.private_ip
}

output "web_server_instance_id" {
  description = "Instance ID of the web server for SSM connection"
  value       = aws_instance.web_server.id
}

output "ansible_controller_instance_id" {
  description = "Instance ID of the Ansible controller for SSM connection"
  value       = aws_instance.ansible_controller.id
}

output "monitoring_server_instance_id" {
  description = "Instance ID of the monitoring server for SSM connection"
  value       = aws_instance.monitoring_server.id
}

output "ecr_repository_uri" {
  description = "URI of the ECR repository for the web application"
  value       = aws_ecr_repository.final_project.repository_url
}