# ----------------------------------
# VARIABLES (can go in variables.tf)
# ----------------------------------
variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "dev-eks-cluster"
}

variable "kubernetes_version" {
  default     = 1.27
  description = "kubernetes version"
}

variable "vpc_id" {
    default = "vpc-012675d45f3fb0ff4"
}
variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}
