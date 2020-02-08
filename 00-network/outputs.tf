
## VPC id
output "vpc_id" {
  value = "${aws_vpc.emr_vpc.id}"
}

## Private subnets
output "subnet-priv-a" {
  value = "${aws_subnet.emr_priv_sub_a.id}"
}

output "subnet-priv-b" {
  value = "${aws_subnet.emr_priv_sub_b.id}"
}

output "subnet-priv-c" {
  value = "${aws_subnet.emr_priv_sub_c.id}"
}

## Public subnets
output "subnet-pub-a" {
  value = "${aws_subnet.emr_pub_sub_a.id}"
}

output "subnet-pub-b" {
  value = "${aws_subnet.emr_pub_sub_b.id}"
}

output "subnet-pub-c" {
  value = "${aws_subnet.emr_pub_sub_c.id}"
}

## CIDRs
output "vpc_cidr" {
  value = "${aws_vpc.emr_vpc.cidr_block}"
}

output "subnet-priv-a-cidr" {
  value = "${aws_subnet.emr_priv_sub_a.cidr_block}"
}