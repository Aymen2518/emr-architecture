## IAM Outputs ##

output "iam_service_role" {
  value = "${aws_iam_role.service_role.id}"
}

output "iam_instance_profile" {
  value = "${aws_iam_instance_profile.instance_profile.id}"
}

output "iam_autoscaling_role" {
  value = "${aws_iam_role.autoscaling_role.id}"
}

output "iam_kms_key_id" {
  value = "${aws_kms_key.key.key_id}"
}

## SSH Outputs ##

output "ssh_key_name" {
  value = "${aws_key_pair.key_pair.key_name}"
}

output "ssh_key" {
  value = "${local_file.ssh_private_key.content}"
}

## Cert Outputs ##

output "certs_archive_path" {
  depends_on = ["data.archive_file.certs"]

  value = "${var.certs_path}/certs.zip"
}
