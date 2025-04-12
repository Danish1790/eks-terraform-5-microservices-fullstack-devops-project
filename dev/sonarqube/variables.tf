variable "region" {
  default = "us-east-1"
}

variable "sonarqube_instance_type" {
  default = "t3.medium"
}

variable "sonarqube_ami" {
  # Ubuntu 24.04 AMI in us-east-1 (can be updated based on latest)
  default = "ami-084568db4383264d4"
}

variable "vpc_id" {
  default = "vpc-0a4fb88ae693fa824"
}

variable "aws_subnet_public1" {
  default = "subnet-04cbdbc6beca59d52"
}

variable "aws_subnet_public2" {
  default = "subnet-0ba0eb942d5c8719d"
}

variable "aws_key_pair_danish" {
  default = "danish-awsp"
}