################### Jobs outputs ###################

output "spark" {
  value = "${module.dns.service_spark_dns}"
}

output "hadoop" {
  value = "${module.dns.service_hadoop_dns}"
}

output "yarn" {
  value = "${module.dns.service_yarn_dns}"
}

output "master" {
  value = "${module.dns.master_dns}"
}


