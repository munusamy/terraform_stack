data "aws_instance" "jenkins_1b" {
  count = "${length(var.common_instance_linux) * var.linux_ins_count}"
  filter {
    name = "tag:Name"
    values = [ "${var.environment}_${element(split(",", lookup(var.common_instance_linux, element(data.aws_availability_zones.available.names, ceil(count.index / var.linux_ins_count)))), count.index % var.linux_ins_count)}" ]
  }
}

output "show_jenkins" {
  value = [ "${data.aws_instance.jenkins_1b.*.id}" ]
}

/*
# Create a Jenkins load balancer
resource "aws_elb" "bar" {
  name               = "jenkins-terraform-elb"
  availability_zones = "${var.elb_az}"

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

#  listener {
#    instance_port      = 8000
#    instance_protocol  = "http"
#    lb_port            = 443
#    lb_protocol        = "https"
#    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${data.aws_instance.jenkins_tag.ids}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "jenkins-terraform-elb"
  }
}
*/
