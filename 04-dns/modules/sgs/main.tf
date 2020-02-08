resource "aws_security_group" "alb_security_group" {
  name                   = "${var.customer}-${terraform.env}-alb"
  vpc_id                 = "${var.vpc_id}"
  revoke_rules_on_delete = "true"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = "${aws_security_group.alb_security_group.id}"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_https" {
  type = "ingress"
  from_port = 443
  security_group_id = "${aws_security_group.alb_security_group.id}"
  protocol = "tcp"
  to_port = 443
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "requests_to_master_services" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.alb_security_group.id}"
  security_group_id        = "${var.master_sg}"
}

resource "aws_security_group_rule" "requests_to_core_services" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.alb_security_group.id}"
  security_group_id        = "${var.core_sg}"
}


