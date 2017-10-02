resource "aws_instance" "linux_bastion" {
  count = "${length(var.subnet_cidr_pvt) * var.layers_pub_count }"

  connection {
    user        = "ubuntu"
    private_key = "${file("../var.aws_keyname.pem")}"
  }

  instance_type          = "t2.micro"
  ami                    = "${lookup(var.aws_amis, var.aws_region)}"
  key_name               = "${var.aws_keyname}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id              = "${element(aws_subnet.pub_subnet.*.id, count.index)}"

  tags {
    Name = "${var.environment}_linux_${element(split(",", lookup(var.subnet_pub_tag, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pub_count)))), count.index % var.layers_pub_count)}"
  }
}

/*
resource "aws_instance" "windows_bastion" {
  count = "${length(var.subnet_cidr_pvt) * var.layers_pub_count }"

  connection {
    user        = "Administrator"
    private_key = "${file("../var.aws_keyname.pem")}"
  }

  instance_type          = "t2.micro"
  ami                    = "${lookup(var.windows_ami, var.aws_region)}"
  key_name               = "${var.aws_keyname}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id              = "${element(aws_subnet.pub_subnet.*.id, count.index)}"

  tags {
    Name = "${var.environment}_windows_${element(split(",", lookup(var.subnet_pub_tag, element(data.aws_availability_zones.available.names, ceil(count.index / var.layers_pub_count)))), count.index % var.layers_pub_count)}"
  }
}
*/
