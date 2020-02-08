output "dns_bastion" {
  value = "${aws_route53_record.dns_record_bastion.name}"
}
