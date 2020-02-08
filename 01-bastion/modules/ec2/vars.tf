variable "project" {
  type = "string"
}

variable "region" {
  description = "Instance region"
  type        = "string"
}

variable "az" {}

variable "team" {}

############
## EC2
############

locals {
  user = "ec2-user"
}

variable "instance_type" {
  description = "Bastion instance type"
  type        = "string"
  default     = "t2.micro"
}

variable "instance_os" {}

variable "bastion_sg_id" {}

variable "subnet_id" {}
