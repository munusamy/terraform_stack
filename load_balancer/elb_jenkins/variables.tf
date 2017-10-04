variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "instance_elb_name" {
  description = "Name tag for Instance ELB"
  default     = "instance"
}

variable "elb_az" {
  type    = "list"
  default = ["us-west-1b", "us-west-1c"]
}

variable "jenkins_tag" {
  description = "postfix tag name of the jenkins instance"

  default = {
    "us-west-1b" = "Jenkins_1b"
    "us-west-1c" = "Jenkins_1c"
  }
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
