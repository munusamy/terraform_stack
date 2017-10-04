variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "jira_elb_name" {
  description = "Name tag for jira ELB"
  default     = "Jira"
}

variable "elb_az" {
  type    = "list"
  default = ["us-west-1b", "us-west-1c"]
}

variable "jira_tag" {
  description = "postfix tag name of the jira instance"

  default = {
    "us-west-1b" = "Jira_1b"
    "us-west-1c" = "Jira_1c"
  }
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
