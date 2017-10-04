variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "artifactory_elb_name" {
  description = "Name tag for Artifactory ELB"
  default     = "Artifactory"
}

variable "elb_az" {
  type    = "list"
  default = ["us-west-1b", "us-west-1c"]
}

variable "artifactory_tag" {
  description = "postfix tag name of the artifactory instance"

  default = {
    "us-west-1b" = "Artifactory_1b"
    "us-west-1c" = "Artifactory_1c"
  }
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
