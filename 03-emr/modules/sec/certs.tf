resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "cert" {
  key_algorithm         = "RSA"
  private_key_pem       = "${tls_private_key.key.private_key_pem}"
  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  dns_names = ["*.${var.region}.compute.internal"]

  subject = {
    common_name  = "*.${var.region}.compute.internal"
    organization = "Company"
    province     = "State"
    country      = "US"
  }
}

data "archive_file" "certs" {
  type        = "zip"
  output_path = "${var.certs_path}/certs.zip"

  source {
    content  = "${tls_private_key.key.private_key_pem}"
    filename = "privateKey.pem"
  }

  source {
    content  = "${tls_self_signed_cert.cert.cert_pem}"
    filename = "certificateChain.pem"
  }

  source {
    content  = "${tls_self_signed_cert.cert.cert_pem}"
    filename = "trustedCertificates.pem"
  }
}

resource "tls_self_signed_cert" "public_cert" {
  key_algorithm         = "RSA"
  private_key_pem       = "${tls_private_key.key.private_key_pem}"
  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  dns_names = ["*.${var.region}.elb.amazonaws.com"]

  subject = {
    common_name  = "*.${var.region}.elb.amazonaws.com"
    organization = "Company"
    province     = "State"
    country      = "US"
  }
}

resource "aws_iam_server_certificate" "public_cert" {
  name             = "${var.customer}-${var.region}"
  certificate_body = "${tls_self_signed_cert.public_cert.cert_pem}"
  private_key      = "${tls_private_key.key.private_key_pem}"
}
