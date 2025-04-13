variable "aws_region" {
  description = "AWS region for ECR"
  type        = string
  default     = "us-east-1" # Replace with your region, e.g., us-west-2
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
  default     = "975050228815" # Replace with your account ID
}