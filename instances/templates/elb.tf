data "aws_instance" "jenkins_1b" {
  filter {
    name = "tag:Name"
    values = [ "preprod_Jenkins_1b" ]
  }
}

data "aws_instance" "jenkins_1c" {
  filter {
    name = "tag:Name"
    values = [ "preprod_Jenkins_1c" ]
  }
}

# Create a Jenkins load balancer
resource "aws_elb" "jenkins" {
  name               = "jenkins-terraform-elb"
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

  instances                   = ["${data.aws_instance.jenkins_1b.id}", "${data.aws_instance.jenkins_1c.id}" ]
  subnets = ["subnet-c616dba1", "subnet-05b2a15d"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  
  tags {
    Name = "jenkins-terraform-elb"
  }
}
