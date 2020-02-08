module "sgs" {
  source          = "./modules/sgs"
  customer        = "${var.customer}"
  vpc_cidr        = "${local.vpc_cidr}"
  vpc_id          = "${local.vpc_id}"
  master_sg       = "${local.master_sg}"
  core_sg         = "${local.core_sg}"
}

module "alb" {
  source             = "modules/alb"
  region             = "${var.region}"
  customer           = "${var.customer}"
  subnet_ids         = ["${local.subnet_ids}"]
  vpc_id             = "${local.vpc_id}"
  alb_security_group = "${module.sgs.alb_security_group}"
  spark_port         = "18080"
  hdfs_port          = "50070"
  yarn_port          = "8088"
  livy_port          = "8998"
  dns_suite          = "${var.dns_suite}"
  acm_arn            = "${var.acm_arn}"
}

module "dns" {
  source         = "modules/dns"
  customer       = "${var.customer}"
  hosted_zone_id = "${var.hosted_zone_id}"
  alb_dns_name   = "${module.alb.alb_dns_name}"
  alb_zone_id    = "${module.alb.alb_zone_id}"
  dns_suite      = "${var.dns_suite}"
}
