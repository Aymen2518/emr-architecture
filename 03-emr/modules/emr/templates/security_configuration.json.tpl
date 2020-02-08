{
  "EncryptionConfiguration": {
    "InTransitEncryptionConfiguration":{
      "TLSCertificateConfiguration":{
        "CertificateProviderType":"PEM",
        "S3Object":"${certs_s3_object}"
      }
    },
    "AtRestEncryptionConfiguration": {
      "S3EncryptionConfiguration": {
        "EncryptionMode": "SSE-S3"
      },
      "LocalDiskEncryptionConfiguration": {
        "EncryptionKeyProviderType": "AwsKms",
        "AwsKmsKey": "${kms_key_id}"
      }
    },
    "EnableInTransitEncryption": true,
    "EnableAtRestEncryption": true
  }
}