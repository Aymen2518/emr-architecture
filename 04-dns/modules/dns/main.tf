resource "aws_route53_record" "dns_record_spark" {
  zone_id = "${var.hosted_zone_id}"
  name    = "${var.customer}-spark.${var.dns_suite}"
  type    = "A"

  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.alb_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dns_record_hadoop" {
  zone_id = "${var.hosted_zone_id}"
  name    = "${var.customer}-hadoop.${var.dns_suite}"
  type    = "A"

  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.alb_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dns_record_yarn" {
  zone_id = "${var.hosted_zone_id}"
  name    = "${var.customer}-yarn.${var.dns_suite}"
  type    = "A"

  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.alb_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dns_record_livy" {
  zone_id = "${var.hosted_zone_id}"
  name    = "${var.customer}-livy.${var.dns_suite}"
  type    = "A"

  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.alb_zone_id}"
    evaluate_target_health = true
  }
}


