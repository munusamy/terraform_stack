# Create a subnet to launch our instances into
# SUBNET RESOURCES
# creates subnet for the cidr provided in "subnet_cidr_pub"
resource "aws_subnet" "pub_subnet" {
  count             = "${length(var.subnet_cidr_pub) * var.layers_pub_count}"
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${element(split(",", lookup(var.subnet_cidr_pub, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pub_count)))), count.index % var.layers_pub_count)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pub_count))}"

  tags {
    Name        = "${var.environment}_${element(split(",", lookup(var.subnet_pub_tag, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pub_count)))), count.index % var.layers_pub_count)}"
    Environment = "${var.environment}"
  }
}

# creates subnet for the cidr provided in "subnet_cidr_pvt"
resource "aws_subnet" "pvt_subnet" {
  count             = "${length(var.subnet_cidr_pvt) * var.layers_pvt_count}"
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${element(split(",", lookup(var.subnet_cidr_pvt, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pvt_count)))), count.index % var.layers_pvt_count)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pvt_count))}"

  tags {
    Name        = "${var.environment}_${element(split(",", lookup(var.subnet_pvt_tag, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pvt_count)))), count.index % var.layers_pvt_count)}"
    Environment = "${var.environment}"
  }
}

# Creates Elastic IP's for the Bastion Hosts
resource "aws_eip" "bastion_eip" {
  count = "${length(var.subnet_cidr_pub)}"
  vpc   = true
}

# Creates NAT Gateway for each Public Subnets
resource "aws_nat_gateway" "gw" {
  count         = "${length(var.subnet_cidr_pub)}"
  allocation_id = "${element(aws_eip.bastion_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.pub_subnet.*.id, count.index)}"
}
