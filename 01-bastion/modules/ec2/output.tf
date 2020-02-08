output "ec2_instance_ip" {
  value = "${aws_instance.ec2.private_ip}"
}

output "ec2_instance_id" {
  value = "${aws_instance.ec2.id}"
}

output "ec2_instance_dns" {
  value = "${aws_instance.ec2.private_dns}"
}

output "ec2_instance_eip" {
  value = "${aws_eip.bastion_eip.public_ip}"
}

output "key_name" {
  value = "${aws_key_pair.key_pair.key_name}"
}