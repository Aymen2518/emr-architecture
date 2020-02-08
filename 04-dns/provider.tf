provider "aws" {
  region  = "${var.region}"
  profile = "${var.aws_profile}"
  version = "~> 1.54"
}
