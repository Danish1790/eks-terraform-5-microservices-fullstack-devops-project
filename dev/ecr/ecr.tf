provider "aws" {
  region = var.aws_region
}


# Common settings for all repositories
locals {
  common_tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  read_write_arns = [
    "arn:aws:iam::012345678901:role/terraform",     # Terraform role
    "arn:aws:iam::012345678901:role/jenkins-role",  # Jenkins role (replace with actual ARN)
    "arn:aws:iam::012345678901:role/eks-node-role"  # EKS role for ArgoCD (replace with actual ARN)
  ]
  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus   = "any", # Matches build numbers (e.g., 1452)
          countType   = "imageCountMoreThan",
          countNumber = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# React Repository
module "ecr_react" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.2"

  repository_name = "reactimage"

  repository_read_write_access_arns = local.read_write_arns

  repository_image_scan_on_push    = true
  repository_image_tag_mutability = "IMMUTABLE"
  repository_force_delete         = true

  repository_lifecycle_policy = local.lifecycle_policy

  tags = merge(local.common_tags, {
    Microservice = "react"
  })
}

# Node.js Repository
module "ecr_node" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.2"

  repository_name = "nodeimage"

  repository_read_write_access_arns = local.read_write_arns

  repository_image_scan_on_push    = true
  repository_image_tag_mutability = "IMMUTABLE"
  repository_force_delete         = true

  repository_lifecycle_policy = local.lifecycle_policy

  tags = merge(local.common_tags, {
    Microservice = "node"
  })
}

# Python Repository
module "ecr_python" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.2"

  repository_name = "pythonimage"

  repository_read_write_access_arns = local.read_write_arns

  repository_image_scan_on_push    = true
  repository_image_tag_mutability = "IMMUTABLE"
  repository_force_delete         = true

  repository_lifecycle_policy = local.lifecycle_policy

  tags = merge(local.common_tags, {
    Microservice = "python"
  })
}