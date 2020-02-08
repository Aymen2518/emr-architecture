########################
# Sgs
########################
output "bastion_sg_id" {
  value = "${module.sgs.bastion_sg_id}"
}

########################
# EC2
########################

output "ec2_instance_ip" {
  value = "${module.ec2.ec2_instance_ip}"
}

output "ec2_instance_id" {
  value = "${module.ec2.ec2_instance_id}"
}

output "ec2_instance_dns" {
  value = "${module.ec2.ec2_instance_dns}"
}

output "ssh_key" {
  value = "${module.ec2.key_name}"
}

#########################
# Jump host configuration
#########################


output "ssh_cfg" {
  value = <<EOF

Host bastion
  Hostname ${module.dns.dns_bastion}

Host *.${var.dns_suite}
  ProxyCommand ssh -F ./ssh.cfg -W %h:%p bastion

Host *
  IdentityFile ~/.ssh/bastion-${terraform.workspace}
  StrictHostKeyChecking False
  User ec2-user

EOF
}

