
provider "aws" {
  region = var.region
}


resource "aws_security_group" "mongodb_sg" {
  name        = "mongodb-sg"
  description = "Allow SSH and mongodb access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "mongodb Web UI"
    from_port   = 27017
    to_port     = 27017
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
    Name = "mongodb-sg"
  }
}

resource "aws_instance" "mongodb" {
  ami                         = var.mongodb_ami
  instance_type               = var.mongodb_instance_type
  subnet_id                   = var.aws_subnet_public2
  associate_public_ip_address = true
  key_name                    = var.aws_key_pair_danish
  vpc_security_group_ids = [aws_security_group.mongodb_sg.id]


  root_block_device {
    volume_size = 40             # ✅ 30 GB
    volume_type = "gp3"           # ✅ gp3
    iops        = 3000            # Optional: gp3 default is 3000
    throughput  = 125             # Optional: gp3 default is 125
    delete_on_termination = true  # Optional: cleans up storage on instance delete
  }

  lifecycle {
    ignore_changes = ["associate_public_ip_address"]
  }

  tags = {
    Name = "mongodb"
  }
}
