# Variables for flexibility
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID of the custom VPC"
  default     = "vpc-023d90f2e392ca23f"
}

variable "db_name" {
  description = "Name of the database"
  default     = "dev"
}