resource "aws_eip" "bastion_eip" {
  vpc = true

  tags {
    Name        = "bastion-eip"
    project     = "${var.project}"
    Environment = "${terraform.workspace}"
  }
}
