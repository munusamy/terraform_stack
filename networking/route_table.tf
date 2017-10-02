
# for each of the private ranges, create a "private" route table.
# Add's Route-Table for individual Subnets as indicated in variables.tf
# file. eg.,, web_subnet_1b,app_subnet_1b,db_subnet_1b ... 
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.default.id}"
  count  = "${length(var.subnet_cidr_pvt) * var.layers_pvt_count }"

  tags {
    Name = "${var.environment}_route_table_${element(split(",", lookup(var.subnet_pvt_tag, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pvt_count)))), count.index % var.layers_pvt_count)}"
  }
}

# add a nat gateway to each private subnet's route table
resource "aws_route" "private_nat_gateway_route" {
  count                  = "${length(var.subnet_cidr_pvt) * var.layers_pvt_count }"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "${var.destination_cidr}"
  depends_on             = ["aws_route_table.private"]
  nat_gateway_id         = "${element(aws_nat_gateway.gw.*.id, count.index)}"
}

resource "aws_route_table_association" "subnet_associate" {
  count          = "${length(var.subnet_cidr_pvt) * var.layers_pvt_count }"
  subnet_id      = "${element(aws_subnet.pvt_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
