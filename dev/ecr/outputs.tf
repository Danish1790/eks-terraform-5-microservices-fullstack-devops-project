output "registry_uri" {
  description = "ECR registry URI"
  value       = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
}

output "react_repository_uri" {
  description = "React repository URI"
  value       = module.ecr_react.repository_url
}

output "node_repository_uri" {
  description = "Node.js repository URI"
  value       = module.ecr_node.repository_url
}

output "python_repository_uri" {
  description = "Python repository URI"
  value       = module.ecr_python.repository_url
}