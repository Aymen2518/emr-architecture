resource "aws_instance" "ec2" {
  ami               = "${var.instance_os}"
  instance_type     = "${var.instance_type}"
  subnet_id         = "${var.subnet_id}"
  availability_zone = "${var.region}${var.az}"
  key_name          = "${aws_key_pair.key_pair.key_name}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
  }

  vpc_security_group_ids = [
    "${var.bastion_sg_id}",
  ]

  tags {
    Name        = "bastion-host"
    project     = "${var.project}"
    Environment = "${terraform.env}"
    Region      = "${var.region}"
  }
}

resource "aws_eip_association" "ec2_eip_association" {
  instance_id = "${aws_instance.ec2.id}"
  allocation_id = "${aws_eip.bastion_eip.id}"
  depends_on = ["aws_instance.ec2"]
}
