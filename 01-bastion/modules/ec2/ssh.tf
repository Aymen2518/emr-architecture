resource "tls_private_key" "ssh_private_key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "local_file" "ssh_private_key" {
  content  = "${tls_private_key.ssh_private_key.private_key_pem}"
  filename = "generated/ssh/bastion-${terraform.env}"
  file_permission = "0400"
}

resource "local_file" "ssh_public_key" {
  content  = "${tls_private_key.ssh_private_key.public_key_openssh}"
  filename = "generated/ssh/bastion-${terraform.env}.pub"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "bastion-${terraform.env}"
  public_key = "${tls_private_key.ssh_private_key.public_key_openssh}"
}
