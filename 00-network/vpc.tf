## Just create main PROD VPC
resource "aws_vpc" "emr_vpc" {
  cidr_block                       = "${var.vpc_cidr}"
  assign_generated_ipv6_cidr_block = false
  enable_dns_hostnames             = true

  tags {
    Name        = "emr-vpc"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}
