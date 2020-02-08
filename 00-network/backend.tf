## This conf exports tfstates in encrypted S3
terraform {
  backend "s3" {
    bucket               = "tfstate-emr-backup"
    dynamodb_table       = "emr-demo"
    key                  = "00-network"
    encrypt              = true
    kms_key_id           = "arn:aws:kms:eu-west-1:878335512140:key/cc54ce95-93d5-4af2-a3be-aba04486122f"
    region               = "eu-west-1"
    profile              = "wescale"
    workspace_key_prefix = ""
  }
}
