terraform {
  backend "s3" {
    bucket         = "terraform-s3-assesment"          # S3 bucket name
    key            = "dev/mongodb/terraform.tfstate"       # Full path inside the bucket
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt        = true
  }
}

