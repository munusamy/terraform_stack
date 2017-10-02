
data "aws_subnet" "private" {
  count = "${length(var.subnet_cidr_pvt)}"
  filter {
    name = "tag:Name"
    # values =  [ "${var.environment}_${lookup(var.subnet_pvt_tag, element(data.aws_availability_zones.available.names, count.index))}" ]
    # values =  [ "${lookup(var.subnet_pvt_tag, "us-west-1b")}" ]

    values = [ "${var.environment}_${lookup(var.subnet_pvt_tag, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pvt_count)))}" ]
  }
}

output "show_subnet" {
	value = [ "${data.aws_subnet.private.id}" ]
}
