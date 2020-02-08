module "sgs" {
  source = "./modules/sgs"

  project = "${var.project}"
  team    = "${var.team}"
  vpc_id  = "${local.vpc_id}"
}

module "ec2" {
  source = "./modules/ec2"

  project       = "${var.project}"
  region        = "${var.region}"
  az            = "${var.az}"
  team          = "${var.team}"
  instance_type = "${var.instance_type}"
  instance_os   = "${local.ami}"
  bastion_sg_id = "${module.sgs.bastion_sg_id}"
  subnet_id     = "${local.public_subnet_a}"
}

module "dns" {
  source             = "./modules/dns"
  hosted_zone_id     = "${var.hosted_zone_id}"
  dns_suite          = "${var.dns_suite}"
  bastion_public_ip = "${module.ec2.ec2_instance_eip}"
}

