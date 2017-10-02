# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "${var.environment}"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "${var.destination_cidr}"
  gateway_id             = "${aws_internet_gateway.default.id}"
}
