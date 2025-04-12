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
  default = "vpc-012675d45f3fb0ff4"
}

variable "aws_subnet_public1" {
  default = "subnet-0205c36aa78677abc"
}

variable "aws_subnet_public2" {
  default = "subnet-0ac467e7f52dbd1cf"
}

variable "aws_key_pair_danish" {
  default = "danish-awsp"
}