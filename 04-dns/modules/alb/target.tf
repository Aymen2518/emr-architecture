#

resource "aws_lb_target_group" "spark" {
  name     = "${var.customer}-spark"
  port     = "${var.spark_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    interval            = 10
    timeout             = 5
  }
}

resource "aws_lb_target_group" "hdfs" {
  name     = "${var.customer}-hdfs"
  port     = "${var.hdfs_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol            = "HTTP"
    path                = "/dfshealth.html"
    matcher             = "200"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    interval            = 10
    timeout             = 5
  }
}

resource "aws_lb_target_group" "yarn" {
  name     = "${var.customer}-yarn"
  port     = "${var.yarn_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol            = "HTTP"
    path                = "/cluster"
    matcher             = "200"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    interval            = 10
    timeout             = 5
  }
}

resource "aws_lb_target_group" "livy" {
  name     = "${var.customer}-livy"
  port     = "${var.livy_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol            = "HTTP"
    path                = "/ui"
    matcher             = "200"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    interval            = 10
    timeout             = 5
  }
}

resource "aws_lb_target_group_attachment" "spark" {
  target_group_arn = "${aws_lb_target_group.spark.arn}"
  target_id        = "${data.aws_instance.master.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "hdfs" {
  target_group_arn = "${aws_lb_target_group.hdfs.arn}"
  target_id        = "${data.aws_instance.master.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "yarn" {
  target_group_arn = "${aws_lb_target_group.yarn.arn}"
  target_id        = "${data.aws_instance.master.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "livy" {
  target_group_arn = "${aws_lb_target_group.livy.arn}"
  target_id        = "${data.aws_instance.master.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "spark" {
  listener_arn = "${aws_lb_listener.https.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.spark.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.customer}-spark.${var.dns_suite}"]
  }
}

resource "aws_lb_listener_rule" "hadoop" {
  listener_arn = "${aws_lb_listener.https.arn}"
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.hdfs.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.customer}-hadoop.${var.dns_suite}"]
  }
}

resource "aws_lb_listener_rule" "yarn" {
  listener_arn = "${aws_lb_listener.https.arn}"
  priority     = 102

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.yarn.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.customer}-yarn.${var.dns_suite}"]
  }
}

resource "aws_lb_listener_rule" "livy" {
  listener_arn = "${aws_lb_listener.https.arn}"
  priority     = 103

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.livy.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.customer}-livy.${var.dns_suite}"]
  }
}
