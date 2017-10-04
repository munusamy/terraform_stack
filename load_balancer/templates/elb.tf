data "aws_instance" "instance" {
  count = "${length(var.instance_tag)}"

  filter {
    name   = "tag:Name"
    values = ["${var.environment}_${lookup(var.instance_tag, element(data.aws_availability_zones.available.names, count.index))}"]
  }
}

# Create a instance load balancer
resource "aws_elb" "instance" {
  name = "${var.environment}-${var.instance_elb_name}"

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${data.aws_instance.instance.*.id}"]
  subnets                     = ["${data.aws_subnet_ids.private1.ids}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "${var.environment}_${var.instance_elb_name}"
  }
}
