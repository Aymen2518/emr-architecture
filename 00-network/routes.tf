#########
## Public Route tables
#########
resource "aws_route_table" "route_table_pub_sub_a" {
  vpc_id = "${aws_vpc.emr_vpc.id}"

  tags {
    Name        = "route-table-pubs-a"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_route_table" "route_table_pub_sub_b" {
  vpc_id = "${aws_vpc.emr_vpc.id}"

  tags {
    Name        = "route-table-pub-b"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_route_table" "route_table_pub_sub_c" {
  vpc_id = "${aws_vpc.emr_vpc.id}"

  tags {
    Name        = "route-table-pub-c"
    project     = "emr-demo"
    Environment = "${terraform.workspace}"
  }
}

## Associate route tables with corresponding subnets
resource "aws_route_table_association" "emr_priv_sub_a" {
  subnet_id      = "${aws_subnet.emr_priv_sub_a.id}"
  route_table_id = "${aws_vpc.emr_vpc.main_route_table_id}"
}

resource "aws_route_table_association" "emr_priv_sub_b" {
  subnet_id      = "${aws_subnet.emr_priv_sub_b.id}"
  route_table_id = "${aws_vpc.emr_vpc.main_route_table_id}"
}

resource "aws_route_table_association" "emr_priv_sub_c" {
  subnet_id      = "${aws_subnet.emr_priv_sub_c.id}"
  route_table_id = "${aws_vpc.emr_vpc.main_route_table_id}"
}

### Public access
resource "aws_route_table_association" "emr_pub_sub_a" {
  subnet_id      = "${aws_subnet.emr_pub_sub_a.id}"
  route_table_id = "${aws_route_table.route_table_pub_sub_a.id}"
}

resource "aws_route_table_association" "emr_pub_sub_b" {
  subnet_id      = "${aws_subnet.emr_pub_sub_b.id}"
  route_table_id = "${aws_route_table.route_table_pub_sub_b.id}"
}

resource "aws_route_table_association" "emr_pub_sub_c" {
  subnet_id      = "${aws_subnet.emr_pub_sub_c.id}"
  route_table_id = "${aws_route_table.route_table_pub_sub_c.id}"
}

############
## Create the main route to internet
############

resource "aws_route" "emr_private_internet_access" {
  route_table_id         = "${aws_vpc.emr_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.emr_natgateway.id}"
}

############
## Create secondary internet access
############
resource "aws_route" "emr_public_internet_access_a" {
  route_table_id         = "${aws_route_table.route_table_pub_sub_a.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.emr_igw.id}"
}

resource "aws_route" "emr_public_internet_access_b" {
  route_table_id         = "${aws_route_table.route_table_pub_sub_b.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.emr_igw.id}"
}

resource "aws_route" "emr_public_internet_access_c" {
  route_table_id         = "${aws_route_table.route_table_pub_sub_c.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.emr_igw.id}"
}
