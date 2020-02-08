variable "customer" {}
variable "cluster_role" {}
variable "certs_s3_object" {}
variable "kms_key_id" {}
variable "release" {}

variable "applications" {
  type = "list"
}

variable "s3_bucket" {}
variable "root_volume_size" {}
variable "subnet_id" {}
variable "master_security_group" {}
variable "core_security_group" {}
variable "instance_profile" {}
variable "autoscaling_role" {}
variable "master_instance_type" {}
variable "master_instance_count_min" {}
variable "core_instance_type" {}
variable "core_instance_count_min" {}
variable "core_instance_count_max" {}
variable "core_volume_size" {}
variable "service_role" {}
variable "service_security_group" {}
variable "bootstrap_script_s3_object" {}
variable "region" {}
variable "ssh_key_name" {}
