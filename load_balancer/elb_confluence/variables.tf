variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "confluence_elb_name" {
  description = "Name tag for confluence ELB"
  default     = "Confluence"
}

variable "elb_az" {
  type    = "list"
  default = ["us-west-1b", "us-west-1c"]
}

variable "confluence_tag" {
  description = "postfix tag name of the confluence instance"

  default = {
    "us-west-1b" = "Confluence_1b"
    "us-west-1c" = "Confluence_1c"
  }
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
