# Region to build the EMR cluster in
# If this is changed you MUST update emr_config_mangement_cidr_blocks

variable "aws_profile" {
  description = "Profile human user will be working with (containing API keys)"
}

variable "region" {
  type        = "string"
  description = "Region where we work"
  default     = "eu-west-1"
}

variable "remote_state_workspace" {
  type = "string"
}

# The Size of the Master
variable "master_instance_type" {
  default = "r4.xlarge"
}

variable "master_instance_count_min" {
  default = 1
}

# The Size of the Core Node
variable "core_instance_type" {
  default = "r4.xlarge"
}

# The initial number of instances to start
variable "core_instance_count_min" {
  default = 1
}

# The maximum number of core nodes to scale up to
variable "core_instance_count_max" {
  default = 3
}

# The EMR release, see: https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-5x.html
variable "emr_release" {
  default = "emr-5.21.0"
}

# The size (in GB) where HDFS will store it's data
variable "core_volume_size" {
  default = 100
}

# The size (in GB) the root filesystem will be
variable "root_volume_size" {
  default = 100
}

# A name for the cluster.  Most AWS resources created will contain this name for easy identification
variable "customer" {
  default = "clinet"
}

# The VPC in which to create the EMR cluster

variable "project" {
  type    = "string"
  default = "project"
}

variable "applications" {
  type = "list"
}

# Data about vpc got from remote state "network"
locals {
  default_workspace = "${terraform.workspace}"
}

locals {
  vpc_id = "${data.terraform_remote_state.network.vpc_id}"
}

locals {
  private_subnet = "${data.terraform_remote_state.network.subnet-priv-a}"
}

locals {
  private_ip_range = "${data.terraform_remote_state.network.subnet-priv-a-cidr}"
}

locals {
  vpc_cidr = "${data.terraform_remote_state.network.vpc_cidr}"
}

locals {
  subnet_ids = ["${data.terraform_remote_state.network.subnet-priv-a}", "${data.terraform_remote_state.network.subnet-priv-b}", "${data.terraform_remote_state.network.subnet-priv-c}"]
}


locals {
  bastion_sg_id = "${data.terraform_remote_state.bastion.bastion_sg_id}"
}

locals {
  ssh_key = "${data.terraform_remote_state.bastion.ssh_key}"
}
