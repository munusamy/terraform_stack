provider "aws" {
  # access_key = "${var.aws_access_key}"
  # secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

data "aws_caller_identity" "current" {}

# collects all the exising Availability Zones
# at that particular(var.aws_region) region 
data "aws_availability_zones" "available" {}
