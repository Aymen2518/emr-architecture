# Region to build the EMR cluster in
# If this is changed you MUST update emr_config_mangement_cidr_blocks

variable "aws_profile" {}

variable "region" {
  type        = "string"
  default     = "eu-west-1"
}

variable "remote_state_workspace" {
  type = "string"
}

# A name for the cluster.  Most AWS resources created will contain this name for easy identification
variable "customer" {
  default = "client"
}

# The VPC in which to create the EMR cluster

variable "project" {
  type    = "string"
}

# Get Entries about DNS zone

variable "hosted_zone_id" {
  type = "string"
}

variable "dns_suite" {}

variable "acm_arn" {}

locals {
  vpc_id = "${data.terraform_remote_state.network.vpc_id}"
}

locals {
  vpc_cidr = "${data.terraform_remote_state.network.vpc_cidr}"
}

locals {
  subnet_ids = ["${data.terraform_remote_state.network.subnet-pub-a}", "${data.terraform_remote_state.network.subnet-pub-b}", "${data.terraform_remote_state.network.subnet-pub-c}"]
}

locals {
  master_sg = "${data.terraform_remote_state.emr.master_sg}"
  core_sg   = "${data.terraform_remote_state.emr.core_sg}"
}
