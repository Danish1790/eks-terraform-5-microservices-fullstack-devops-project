
provider "aws" {
  region = var.region
}


resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-sg"
  description = "Allow SSH and Sonarqube access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SonarQube Web Access"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sonarqube-sg"
  }
}

resource "aws_instance" "sonarqube" {
  ami                         = var.sonarqube_ami
  instance_type               = var.sonarqube_instance_type
  subnet_id                   = var.aws_subnet_public2
  associate_public_ip_address = true
  key_name                    = var.aws_key_pair_danish
  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]


  root_block_device {
    volume_size = 40             # ✅ 35 GB
    volume_type = "gp3"           # ✅ gp3
    iops        = 3000            # Optional: gp3 default is 3000
    throughput  = 125             # Optional: gp3 default is 125
    delete_on_termination = true  # Optional: cleans up storage on instance delete
  }
  
  lifecycle {
    ignore_changes = ["associate_public_ip_address"]
  }

  tags = {
    Name = "sonarqube"
  }
}
