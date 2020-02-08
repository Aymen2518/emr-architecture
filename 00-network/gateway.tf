######## Internet Gateway ########
resource "aws_internet_gateway" "emr_igw" {
  vpc_id = "${aws_vpc.emr_vpc.id}"

  tags {
    Name        = "emr-igw"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

######## Eip to be used in the natgateway

resource "aws_eip" "emr_eip" {
  vpc        = true
  depends_on = ["aws_internet_gateway.emr_igw"]

  tags {
    Name        = "emr-eip"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

######## Nat gateway ########
resource "aws_nat_gateway" "emr_natgateway" {
  allocation_id = "${aws_eip.emr_eip.id}"
  subnet_id     = "${aws_subnet.emr_pub_sub_a.id}"

  tags {
    Name        = "emr-gw"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }

  depends_on = ["aws_internet_gateway.emr_igw"]
}
