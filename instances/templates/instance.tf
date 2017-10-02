# Collects all the Subnet Id's by matching with the
# Aws Name Tag 
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

# Creates Linux Instances by collecting the server_names
# from the "common_instance_linux" variable.

resource "aws_instance" "common_linux" {
  count = "${length(var.common_instance_linux) * var.linux_ins_count}"
  connection {
    user        = "${var.linux_user}"
    private_key = "${file("../var.aws_keyname.pem")}"
  }

  instance_type          = "${var.instance_size}"
  ami                    = "${lookup(var.linux_ami, element(split(",", lookup(var.common_instance_linux, element(data.aws_availability_zones.available.names, ceil(count.index / var.linux_ins_count)))), count.index % var.linux_ins_count))}"
  key_name               = "${var.aws_keyname}"
  vpc_security_group_ids = ["${data.aws_security_group.app_sg.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.private1.ids, ceil(count.index / var.linux_ins_count))}"

  tags {
    Name = "${var.environment}_${element(split(",", lookup(var.common_instance_linux, element(data.aws_availability_zones.available.names, ceil(count.index / var.linux_ins_count)))), count.index % var.linux_ins_count)}"
  }
}
/*
# Creates Windows Instances by collecting the server_names
# from the "common_instance_windows" variable.
resource "aws_instance" "common_windows" {
  count = "${length(var.common_instance_windows) * var.windows_ins_count}"
  connection {
    user        = "${var.windows_user}"
    private_key = "${file("../var.aws_keyname.pem")}"
  }

  instance_type          = "${var.instance_size}"
  ami                    = "${lookup(var.windows_ami, element(split(",", lookup(var.common_instance_windows, element(data.aws_availability_zones.available.names, ceil(count.index / var.windows_ins_count)))), count.index % var.windows_ins_count))}"
  key_name               = "${var.aws_keyname}"
  vpc_security_group_ids = ["${data.aws_security_group.app_sg.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.private1.ids, ceil(count.index / var.windows_ins_count))}"

  tags {
    Name = "${var.environment}_${element(split(",", lookup(var.common_instance_windows, element(data.aws_availability_zones.available.names, ceil(count.index / var.windows_ins_count)))), count.index % var.windows_ins_count)}"
  }
}
*/
