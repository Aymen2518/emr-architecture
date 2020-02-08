variable "region" {}
variable "customer" {}

variable "subnet_ids" {
  type = "list"
}

variable "vpc_id" {}
variable "alb_security_group" {}
variable "spark_port" {}
variable "yarn_port" {}
variable "livy_port" {}
variable "hdfs_port" {}
variable "dns_suite" {}
variable "acm_arn" {}
