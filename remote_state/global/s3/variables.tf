variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default = "terraform-remote-state-s3bucket"
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default = "terraform-remote-state-backend-table"
}