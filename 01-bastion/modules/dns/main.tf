resource "aws_route53_record" "dns_record_bastion" {
  zone_id = "${var.hosted_zone_id}"
  name    = "bastion.${var.dns_suite}"
  type    = "A"
  ttl     = 300
  records = ["${var.bastion_public_ip}"]
}
