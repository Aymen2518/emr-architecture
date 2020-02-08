data "aws_instance" "master" {
  filter {
    name   = "tag:Name"
    values = ["${var.customer}-jobs"]
  }

  filter {
    name   = "tag:aws:elasticmapreduce:instance-group-role"
    values = ["MASTER"]
  }
}

resource "aws_lb" "master_lb" {
  name               = "alb-ui-${var.customer}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.alb_security_group}"]
  subnets            = ["${var.subnet_ids}"]

  tags {
    Name        = "${var.customer}-alb"
    Environment = "${terraform.env}"
    Region      = "${var.region}"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = "${aws_lb.master_lb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.acm_arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.spark.arn}"
  }
}

resource "aws_lb_listener" "service_redirect" {
  load_balancer_arn = "${aws_lb.master_lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
