provider "aws" {
  region = var.region
}

# Data source to fetch the existing dev-vpc
data "aws_vpc" "dev_vpc" {
  id = var.vpc_id
}

# Data source to fetch subnets in the dev-vpc
data "aws_subnets" "dev_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.dev_vpc.id]
  }
}

# Reference the existing Security Group instead of creating a new one
data "aws_security_group" "rds_sg" {
  name   = "postgres-rds-sg"
  vpc_id = data.aws_vpc.dev_vpc.id
}

# Secrets Manager for RDS Credentials
data "aws_secretsmanager_secret" "rds_credentials" {
  arn = "arn:aws:secretsmanager:us-east-1:975050228815:secret:rds-postgres-credentials-Fdl1Xg"
}

data "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = data.aws_secretsmanager_secret.rds_credentials.id
}

locals {
  rds_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_credentials.secret_string)
}

# RDS PostgreSQL Instance using the module
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "postgres-rds"

  engine            = "postgres"
  engine_version    = "16.4"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = var.db_name
  username = local.rds_credentials.username
  password = local.rds_credentials.password
  port     = "5432"

  iam_database_authentication_enabled = false

  vpc_security_group_ids = [data.aws_security_group.rds_sg.id] # Use existing SG

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7

  # Enhanced Monitoring
  monitoring_interval    = 0
  monitoring_role_name   = "PostgresRDSMonitoringRole"
  create_monitoring_role = false # Do not create the role if it exists

  tags = {
    Name        = "PostgresRDS"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = data.aws_subnets.dev_subnets.ids

  # DB parameter group
  family = "postgres16"

  # DB option group
  major_engine_version = "16"

  # Database Deletion Protection
  deletion_protection = false

  # Skip final snapshot
  skip_final_snapshot = true

  options = []
}

# Output RDS Endpoint
output "rds_endpoint" {
  value = module.db.db_instance_endpoint
}