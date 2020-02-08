resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg-${terraform.workspace}"
  description = "Bastion Security Groups-${terraform.workspace}"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    project = "${var.project}"
    Name    = "bastion-security-group"
    Environment = "${terraform.env}"
  }
}

resource "aws_security_group_rule" "bastion_sg_rule" {
  from_port = 22
  protocol = "tcp"
  security_group_id = "${aws_security_group.bastion_sg.id}"
  to_port = 22
  type = "ingress"
  cidr_blocks = ["194.59.249.245/32","0.0.0.0/0"]
}