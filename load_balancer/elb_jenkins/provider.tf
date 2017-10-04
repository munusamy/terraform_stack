provider "aws" {
  # access_key = "${var.aws_access_key}"
  # secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

data "aws_caller_identity" "current" {}

data "aws_vpc" "get_vpc_id" {
  tags {
    Name = "preprod"
  }
}

data "aws_availability_zones" "available" {}

data "aws_subnet_ids" "private1" {
  vpc_id = "${data.aws_vpc.get_vpc_id.id}"

  tags {
    Name = "*app_subnet*"
  }
}

# Collects the Security Group Id's by matching
# with the AWS Name Tag
data "aws_security_group" "app_sg" {
  vpc_id = "${data.aws_vpc.get_vpc_id.id}"

  tags {
    Name = "base_sg"
  }
}
