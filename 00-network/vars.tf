variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "region" {
  type    = "string"
  default = "eu-west-1"
}

variable "aws_profile" {
  type    = "string"
  default = "wescale"
}

variable "subnet_size" {
  description = "Subnet size, base on cidrsubnet function"
  default     = "5"
}
