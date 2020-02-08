output "alb_dns_name" {
  value = "${aws_lb.master_lb.dns_name}"
}

output "alb_zone_id" {
  value = "${aws_lb.master_lb.zone_id}"
}
