variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "bitbucket_elb_name" {
  description = "Name tag for Jenkins ELB"
  default     = "Bitbucket"
}

variable "elb_az" {
  type    = "list"
  default = ["us-west-1b", "us-west-1c"]
}

variable "bitbucket_tag" {
  description = "postfix tag name of the bitbucket instance"

  default = {
    "us-west-1b" = "Bitbucket_1b"
    "us-west-1c" = "Bitbucket_1c"
  }
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
