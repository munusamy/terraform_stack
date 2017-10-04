data "aws_instance" "confluence" {
  count = "${length(var.confluence_tag)}"

  filter {
    name   = "tag:Name"
    values = ["${var.environment}_${lookup(var.confluence_tag, element(data.aws_availability_zones.available.names, count.index))}"]
  }
}

# Create a confluence load balancer
resource "aws_elb" "confluence" {
  name = "${var.environment}-${var.confluence_elb_name}"

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

  instances                   = ["${data.aws_instance.confluence.*.id}"]
  subnets                     = ["${data.aws_subnet_ids.private1.ids}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "${var.environment}_${var.confluence_elb_name}"
  }
}
