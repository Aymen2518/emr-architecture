module "sec" {
  source     = "./modules/sec"
  customer   = "${var.customer}"
  region     = "${var.region}"
  vpc_id     = "${local.vpc_id}"
}

module "sgs" {
  source          = "./modules/sgs"
  customer        = "${var.customer}"
  vpc_cidr        = "${local.vpc_cidr}"
  vpc_id          = "${local.vpc_id}"
  subnet_ip_range = "${local.private_ip_range}"
  bastion_sg_id   = "${local.bastion_sg_id}"
}

module "s3" {
  source   = "./modules/s3"
  customer = "${var.customer}"
  region   = "${var.region}"
}

module "bootstrap" {
  source             = "./modules/bootstrap"
  customer           = "${var.customer}"
  region             = "${var.region}"
  certs_archive_path = "${module.sec.certs_archive_path}"
}

module "emr_jobs" {
  source                     = "./modules/emr"
  customer                   = "${var.customer}"
  region                     = "${var.region}"
  cluster_role               = "jobs"
  certs_s3_object            = "${module.bootstrap.certs_s3_object}"
  kms_key_id                 = "${module.sec.iam_kms_key_id}"
  release                    = "${var.emr_release}"
  applications               = "${var.applications}"
  s3_bucket                  = "${module.s3.bucket}"
  root_volume_size           = "${var.root_volume_size}"
  subnet_id                  = "${local.private_subnet}"
  master_security_group      = "${module.sgs.master_security_group}"
  master_instance_count_min  = "${var.master_instance_count_min}"
  core_security_group        = "${module.sgs.core_security_group}"
  instance_profile           = "${module.sec.iam_instance_profile}"
  autoscaling_role           = "${module.sec.iam_autoscaling_role}"
  ssh_key_name               = "${local.ssh_key}"
  master_instance_type       = "${var.master_instance_type}"
  core_instance_type         = "${var.core_instance_type}"
  core_instance_count_min    = "${var.core_instance_count_min}"
  core_instance_count_max    = "${var.core_instance_count_max}"
  core_volume_size           = "${var.core_volume_size}"
  service_role               = "${module.sec.iam_service_role}"
  service_security_group     = "${module.sgs.service_security_group}"
  bootstrap_script_s3_object = "${module.bootstrap.bootstrap_script_s3_object}"
}
