variable "region" {
  default = "us-east-1"
}

variable "sonarqube_instance_type" {
  default = "t3.medium"
}

variable "sonarqube_ami" {
  # Ubuntu 24.04 AMI in us-east-1 (can be updated based on latest)
  default = "ami-02c77e5184210e5d4"
}

variable "vpc_id" {
  default = "vpc-023d90f2e392ca23f"
}

variable "aws_subnet_public1" {
  default = "subnet-01afa1fc2e3ccef14"
}

variable "aws_subnet_public2" {
  default = "subnet-0c5132e193c829fcb"
}

variable "aws_key_pair_danish" {
  default = "danish-awsp"
}