terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
      bucket    = "terraform-remote-state-s3bucket"
      key       = "global/s3/terraform.tfstate"
      region    = "us-east-1"
      dynamodb_table = "terraform-remote-state-backend-table"
      encrypt        = true
     }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = var.bucket_name
  force_destroy = true
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}