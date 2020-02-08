##########
## Private networks
##########

resource "aws_subnet" "emr_priv_sub_a" {
  vpc_id            = "${aws_vpc.emr_vpc.id}"
  cidr_block        = "${cidrsubnet("${aws_vpc.emr_vpc.cidr_block}", "${var.subnet_size}", 0)}"
  availability_zone = "${var.region}a"

  tags {
    Name        = "private-subnet-a"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_subnet" "emr_priv_sub_b" {
  vpc_id            = "${aws_vpc.emr_vpc.id}"
  cidr_block        = "${cidrsubnet("${aws_vpc.emr_vpc.cidr_block}", "${var.subnet_size}", 1)}"
  availability_zone = "${var.region}b"

  tags {
    Name        = "private-subnet-b"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_subnet" "emr_priv_sub_c" {
  vpc_id            = "${aws_vpc.emr_vpc.id}"
  cidr_block        = "${cidrsubnet("${aws_vpc.emr_vpc.cidr_block}", "${var.subnet_size}", 2)}"
  availability_zone = "${var.region}c"

  tags {
    Name        = "private-subnet-c"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

##########
## Public networks
##########

resource "aws_subnet" "emr_pub_sub_a" {
  vpc_id            = "${aws_vpc.emr_vpc.id}"
  cidr_block        = "${cidrsubnet("${aws_vpc.emr_vpc.cidr_block}", "${var.subnet_size}", 3)}"
  availability_zone = "${var.region}a"

  tags {
    Name        = "public-subnet-a"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_subnet" "emr_pub_sub_b" {
  vpc_id            = "${aws_vpc.emr_vpc.id}"
  cidr_block        = "${cidrsubnet("${aws_vpc.emr_vpc.cidr_block}", "${var.subnet_size}", 4)}"
  availability_zone = "${var.region}b"

  tags {
    Name        = "public-subnet-b"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_subnet" "emr_pub_sub_c" {
  vpc_id            = "${aws_vpc.emr_vpc.id}"
  cidr_block        = "${cidrsubnet("${aws_vpc.emr_vpc.cidr_block}", "${var.subnet_size}", 5)}"
  availability_zone = "${var.region}c"

  tags {
    Name        = "public-subnet-c"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}
