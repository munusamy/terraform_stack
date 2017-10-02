provider "aws" {
  # access_key = "${var.aws_access_key}"
  # secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

data "aws_caller_identity" "current" {}
data "aws_vpc" "get_vpc_id" {
	tags {
	  Name = "preprod"
	}
}
data "aws_availability_zones" "available" {}