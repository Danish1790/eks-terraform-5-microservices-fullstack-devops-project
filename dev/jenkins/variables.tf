variable "region" {
  default = "us-east-1"
}

variable "jenkins_instance_type" {
  default = "t3.large"
}

variable "jenkins_ami" {
  # Ubuntu 24.04 AMI in us-east-1 (can be updated based on latest)
  default = "ami-02b5902a0c7eef249"
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