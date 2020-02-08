output "bootstrap_script_s3_object" {
  value = "s3://${aws_s3_bucket.bootstrap.bucket}/${aws_s3_bucket_object.configure_system.id}"
}

output "certs_s3_object" {
  value = "s3://${aws_s3_bucket.bootstrap.bucket}/${aws_s3_bucket_object.certs.id}"
}
