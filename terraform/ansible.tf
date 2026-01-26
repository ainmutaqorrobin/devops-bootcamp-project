# Generate Ansible inventory file from Terraform outputs

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content = templatefile("${path.module}/inventory.tpl", {
    web_server_ip          = aws_eip.web_eip.public_ip
    ansible_controller_ip  = aws_instance.ansible_controller.private_ip
    monitoring_server_ip   = aws_instance.monitoring_server.private_ip
    ssh_private_key        = "${path.module}/../ansible/ansible-key.pem"
    ecr_repository_uri     = aws_ecr_repository.final_project.repository_url
  })

  depends_on = [
    aws_instance.web_server,
    aws_instance.ansible_controller,
    aws_instance.monitoring_server,
    aws_eip.web_eip,
    local_file.private_key_pem,
  ]
}