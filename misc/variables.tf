variable "aws_region" {
  default = "us-west-1"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "subnet_cidr_pub" {
  type = "map"

  default = {
    "us-west-1b" = "10.0.1.0/24"
    "us-west-1c" = "10.0.5.0/24"
  }
}

variable "subnet_cidr_pvt" {
  type = "map"

  default = {
    "us-west-1b" = "10.0.2.0/24,10.0.3.0/24,10.0.4.0/24"
    "us-west-1c" = "10.0.6.0/24,10.0.7.0/24,10.0.8.0/24"
  }
}

variable "subnet_pub_tag" {
  type = "map"

  default = {
    "us-west-1b" = "bastion_1b"
    "us-west-1c" = "bastion_1c"
  }
}

variable "subnet_pvt_tag" {
  type = "map"

  default = {
    "us-west-1b" = "web_subnet_1b,app_subnet_1b,db_subnet_1b"
    "us-west-1c" = "web_subnet_1c,app_subnet_1c,db_subnet_1c"
  }
}

variable "layers_pvt_count" {
  type    = "string"
  default = "3"
}

variable "layers_pub_count" {
  type    = "string"
  default = "1"
}

variable "aws_amis" {
  description = "AMI-ID for Bastion Hosts."
  type        = "map"

  default = {
    "us-west-1" = "ami-05f3b465"
  }
}

variable "windows_ami" {
  description = "ami-id for windows bastion"
  type        = "map"

  default = {
    "us-west-1" = "ami-65c7ec05"
  }
}

variable "aws_keyname" {
  description = "aws pem_key to login to the server"
  default     = "PJ"
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
