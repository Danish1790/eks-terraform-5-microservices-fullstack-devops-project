# ----------------------------------
# VARIABLES (can go in variables.tf)
# ----------------------------------
variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "my-eks-cluster"
}

variable "vpc_id" {
    default = "vpc-0a4fb88ae693fa824"
}
variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}
