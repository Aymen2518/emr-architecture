resource "aws_security_group" "master_security_group" {
  name                   = "${var.customer}-${terraform.env}-master"
  vpc_id                 = "${var.vpc_id}"
  revoke_rules_on_delete = "true"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "core_security_group" {
  name                   = "${var.customer}-${terraform.env}-core"
  vpc_id                 = "${var.vpc_id}"
  revoke_rules_on_delete = "true"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "service_security_group" {
  name                   = "${var.customer}-${terraform.env}-service"
  vpc_id                 = "${var.vpc_id}"
  revoke_rules_on_delete = "true"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "service_access_rule_from_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = -1
  source_security_group_id = "${aws_security_group.master_security_group.id}"
  security_group_id        = "${aws_security_group.service_security_group.id}"
}

resource "aws_security_group_rule" "service_access_rule_from_slave" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = -1
  source_security_group_id = "${aws_security_group.core_security_group.id}"
  security_group_id        = "${aws_security_group.service_security_group.id}"
}

resource "aws_security_group_rule" "ssh_to_master_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${var.bastion_sg_id}"
  security_group_id        = "${aws_security_group.master_security_group.id}"
}

resource "aws_security_group_rule" "master_to_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.master_security_group.id}"
  security_group_id        = "${aws_security_group.master_security_group.id}"
}

resource "aws_security_group_rule" "core_to_core" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.core_security_group.id}"
  security_group_id        = "${aws_security_group.core_security_group.id}"
}

resource "aws_security_group_rule" "ssh_to_core_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${var.bastion_sg_id}"
  security_group_id        = "${aws_security_group.core_security_group.id}"
}

resource "aws_security_group_rule" "master_to_core" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.master_security_group.id}"
  security_group_id        = "${aws_security_group.core_security_group.id}"
}

resource "aws_security_group_rule" "core_to_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.core_security_group.id}"
  security_group_id        = "${aws_security_group.master_security_group.id}"
}
