variable "aws_profile" {
  description = "Profile human user will be working with (containing API keys)"
}

variable "remote_state_workspace" {
  type = "string"
}

variable "project" {
  type = "string"
}

variable "region" {
  description = "Instance region"
  type        = "string"
}

variable "team" {
  type    = "string"
  default = "Data"
}

variable "az" {
  type = "string"
}

variable "instance_name" {
  default = "bastion"
}

variable "network_layer" {
  type        = "string"
  description = "The workspace we reference in other layers, such as the network layer"
  default     = ""
}

variable "hosted_zone_id" {
  type = "string"
}

variable "dns_suite" {
  type = "string"
}

########################
## VPC
########################

locals {
  vpc_id           = "${data.terraform_remote_state.network.vpc_id}"
  private_subnet_a = "${data.terraform_remote_state.network.subnet-priv-a}"
  public_subnet_a  = "${data.terraform_remote_state.network.subnet-pub-a}"
}

########################
## EC2
########################

variable "instance_type" {
  description = "Bastion instance type"
  type        = "string"
  default     = "t2.micro"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  owners   = ["amazon"]
}

locals {
  ami = "${data.aws_ami.amazon-linux-2.id}"
}
