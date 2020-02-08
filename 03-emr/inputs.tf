data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket               = "tfstate-emr-backup"
    key                  = "00-network"
    encrypt              = true
    kms_key_id           = "arn:aws:kms:eu-west-1:878335512140:key/cc54ce95-93d5-4af2-a3be-aba04486122f"
    region               = "eu-west-1"
    profile              = "wescale"
    workspace_key_prefix = ""
  }
}

data "terraform_remote_state" "bastion" {
  backend = "s3"

  config {
    bucket               = "tfstate-emr-backup"
    key                  = "01-bastion"
    encrypt              = true
    kms_key_id           = "arn:aws:kms:eu-west-1:878335512140:key/cc54ce95-93d5-4af2-a3be-aba04486122f"
    region               = "eu-west-1"
    profile              = "wescale"
    workspace_key_prefix = ""
  }
}
