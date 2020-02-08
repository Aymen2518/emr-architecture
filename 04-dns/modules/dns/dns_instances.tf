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


resource "aws_route53_record" "dns_record_master" {
  zone_id = "${var.hosted_zone_id}"
  name    = "${var.customer}-master.${var.dns_suite}"
  type    = "A"
  ttl     = 300

  records = ["${data.aws_instance.master.private_ip}"]
}
