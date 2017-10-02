resource "aws_instance" "instance" {
  # creates instances on each AZ's
  count = "${length(var.subnet_cidr_pvt)}"

  connection {
    user        = "centos"
    private_key = "${file("../var.aws_keyname.pem")}"
  }

  instance_type          = "${var.instance_size}"
  ami                    = "${lookup(var.aws_amis, var.aws_region)}"
  key_name               = "${var.aws_keyname}"
  vpc_security_group_ids = ["${var.base_sg}"]
  subnet_id              = "${var.environment}_${lookup(var.subnet_pvt_tag, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pvt_count)))}"

  tags {
    Name = "${var.environment}_${var.instance_name}_${lookup(var.subnet_pvt_tag, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pvt_count)))}"
  }
}