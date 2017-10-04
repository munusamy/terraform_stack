variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "bucket_name" {
  description = "Name tag for s3 bucket"
  default     = "esurance-test-rl"
}
