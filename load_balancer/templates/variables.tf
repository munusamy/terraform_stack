variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "instance_elb_name" {
  description = "Name tag for instance ELB"
  default     = "Instance"
}

variable "elb_az" {
  type    = "list"
  default = ["us-west-1b", "us-west-1c"]
}

variable "instance_tag" {
  description = "postfix tag name of the instance instance"

  default = {
    "us-west-1b" = "Instance_1b"
    "us-west-1c" = "Instance_1c"
  }
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
