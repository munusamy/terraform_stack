variable "aws_region" {
  default = "us-west-1"
}

variable "aws_access_key" {
  default = "AKIAIID3N2E44VNBTWFA"
}

variable "aws_secret_key" {
  default = "kIM1hhcc2SZUjse2OIahgKdmB/PDJ4Grf0MVj99/"
}

variable "environment" {
  type    = "string"
  default = "preprod"
}

variable "instance_name" {
  description = "Name of the Instance"
  default = "jenkins"
}

variable "instance_size" {
  description = "Size of the Instance"
  default = "t2.micro"
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
    "us-west-1b" = "10.0.3.0/24"
    "us-west-1c" = "10.0.7.0/24"
  }
}

variable "layers_pvt_count" {
  type    = "string"
  default = "1"
}

variable "subnet_pvt_tag" {
  type = "map"

  default = {
    "us-west-1b" = "app_subnet_1b"
    "us-west-1c" = "app_subnet_1c"
  }
}

variable "aws_amis" {
  description = "AMI-ID for Instances."
  type        = "map"

  default = {
    "us-west-1" = "ami-05f3b465"
  }
}


variable "aws_keyname" {
  description = "aws pem_key to login to the server"
  default     = "chefserver"
}

variable "base_sg" {
  description = "Common Security Group for all the Instances"
  default     = "base_sg"
}
