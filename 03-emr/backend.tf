## This conf exports tfstates in encrypted S3
terraform {
  backend "s3" {
    bucket               = "tfstate-emr-backup"
    dynamodb_table       = "emr-demo"
    key                  = "03-emr"
    encrypt              = true
    kms_key_id           = ""
    region               = "eu-west-1"
    profile              = "wescale"
    workspace_key_prefix = ""
  }
}
