provider "aws" {
  region  = "${var.region}"
  profile = "${var.aws_profile}"
  version = "~> 2.0"
}
