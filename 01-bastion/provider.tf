provider "aws" {
  region  = "${var.region}"
  profile = "${var.aws_profile}"
  version = "~> 2.0"
}

terraform {
  required_version = "0.11.14"
}
