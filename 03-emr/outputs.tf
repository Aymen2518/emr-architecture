output "master_sg" {
  value = "${module.sgs.master_security_group}"
}

output "core_sg" {
  value = "${module.sgs.core_security_group}"
}

output "service_sg" {
  value = "${module.sgs.service_security_group}"
}
