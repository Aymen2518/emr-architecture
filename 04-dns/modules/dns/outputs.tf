################### outputs ###################

output "service_spark_dns" {
  value = "${aws_route53_record.dns_record_spark.name}"
}

output "service_hadoop_dns" {
  value = "${aws_route53_record.dns_record_hadoop.name}"
}

output "service_yarn_dns" {
  value = "${aws_route53_record.dns_record_yarn.name}"
}

output "master_dns" {
  value = "${aws_route53_record.dns_record_master.name}"
}

