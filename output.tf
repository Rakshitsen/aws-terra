output "Jenkins_master" {
  description = "Private IP of Jenkins master"
  value       = aws_instance.Jenkins_master.private_ip
}

output "kubernetes_master" {
  description = "Private IP of Kubernetes master"
  value       = aws_instance.K8s_master.private_ip
}

output "kubernetes_slave" {
  description = "Private IPs of Kubernetes slave nodes"
  value       = aws_instance.K8s_slave[*].private_ip
}
