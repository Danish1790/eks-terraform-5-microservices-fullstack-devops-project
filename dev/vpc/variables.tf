variable "vpc_name" {
  default = "dev-vpc"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets_per_az" {
  description = "Number of public subnets per AZ"
  type        = number
  default     = 2
}

variable "private_subnets_per_az" {
  description = "Number of private subnets per AZ"
  type        = number
  default     = 2
}

