resource "aws_kms_key" "key" {
  description = "${var.customer}-${terraform.env}"
}

resource "aws_kms_grant" "grant" {
  name              = "${var.customer}-${terraform.env}"
  key_id            = "${aws_kms_key.key.key_id}"
  grantee_principal = "${aws_iam_role.instance_role.arn}"
  operations        = ["Encrypt", "Decrypt", "ReEncryptFrom", "ReEncryptTo", "GenerateDataKey", "DescribeKey"]
}

######################################
# Settings for emr assume role policy
######################################

data "aws_iam_policy_document" "emr_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "service_role" {
  name               = "${var.customer}-service"
  assume_role_policy = "${data.aws_iam_policy_document.emr_assume_role_policy.json}"
}

data "aws_iam_policy_document" "emr_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CancelSpotInstanceRequests",
      "ec2:CreateNetworkInterface",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteTags",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstances",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribePrefixLists",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSpotInstanceRequests",
      "ec2:DescribeSpotPriceHistory",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeVpcEndpointServices",
      "ec2:DescribeVpcs",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:RequestSpotInstances",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RunInstances",
      "ec2:TerminateInstances",
      "ec2:DeleteVolume",
      "ec2:DescribeVolumeStatus",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListInstanceProfiles",
      "iam:ListRolePolicies",
      "iam:PassRole",
      "s3:CreateBucket",
      "s3:Get*",
      "s3:List*",
      "sdb:BatchPutAttributes",
      "sdb:Select",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DeleteAlarms",
      "application-autoscaling:RegisterScalableTarget",
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:DeleteScalingPolicy",
      "application-autoscaling:Describe*",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceLinkedRole",
    ]

    resources = [
      "arn:aws:iam::*:role/aws-service-role/spot.amazonaws.com/AWSServiceRoleForEC2Spot*",
    ]

    condition {
      test     = "StringLike"
      values   = ["spot.amazonaws.com"]
      variable = "iam:AWSServiceName"
    }
  }
}

resource "aws_iam_role_policy" "service_role_base" {
  name = "${var.customer}-service-base-jobs"
  role = "${aws_iam_role.service_role.id}"

  policy = "${data.aws_iam_policy_document.emr_role_policy.json}"
}

# Settings for instance profiles

###########################################
# this role is for emr_jobs cluster
###########################################

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "instance_role" {
  name               = "${var.customer}-instance-role-jobs"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.customer}-instance-profile-jobs"
  role = "${aws_iam_role.instance_role.id}"
}

data "aws_iam_policy_document" "instance_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:*",
      "ec2:Describe*",
      "elasticmapreduce:Describe*",
      "elasticmapreduce:ListBootstrapActions",
      "elasticmapreduce:ListClusters",
      "elasticmapreduce:ListInstanceGroups",
      "elasticmapreduce:ListInstances",
      "elasticmapreduce:ListSteps",
      "s3:ListAllBuckets",
    ]

    resources = [
      "*",
    ]
  }

  # Allow bucket listing to visualize objects
  statement {
    effect = "Allow"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.customer}-demo-technical-logs",
      "arn:aws:s3:::${var.customer}-demo-technical-bootstrap",
      "arn:aws:s3:::${var.customer}-demo-data",
    ]
  }

  # Rule for read/write objects to technical buckets buckets
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.customer}-demo-technical-logs/*",
      "arn:aws:s3:::${var.customer}-demo-technical-bootstrap/*",
    ]
  }

  # Rule for read/write/delete Objects from buckets
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:GetObjectVersion",
    ]

    resources = [
      "arn:aws:s3:::${var.customer}-demo-data",
      "arn:aws:s3:::${var.customer}-demo-data/*",
    ]
  }

  statement {
    effect = "Deny"

    actions = [
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${var.customer}-demo-technical-emr-logs/logs/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey",
    ]

    resources = [
      "${aws_kms_key.key.arn}",
    ]
  }
}

resource "aws_iam_role_policy" "instance_profile_base" {
  name = "${var.customer}-service-base-jobs"
  role = "${aws_iam_role.instance_role.id}"

  policy = "${data.aws_iam_policy_document.instance_role_policy.json}"
}


#########################################
# Settings for autoscaling configuration
#########################################

data "aws_iam_policy_document" "autoscaling_role_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [
        "application-autoscaling.amazonaws.com",
        "elasticmapreduce.amazonaws.com",
      ]

      type = "Service"
    }
  }
}

resource "aws_iam_role" "autoscaling_role" {
  name = "${var.customer}-${terraform.env}-autoscaling"

  assume_role_policy = "${data.aws_iam_policy_document.autoscaling_role_document.json}"
}

data "aws_iam_policy_document" "autoscaling_base_document" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudwatch:DescribeAlarms",
      "elasticmapreduce:ListInstanceGroups",
      "elasticmapreduce:ModifyInstanceGroups",
    ]
  }
}

resource "aws_iam_role_policy" "autoscaling_base" {
  name = "${var.customer}-${terraform.env}-autoscaling-base"
  role = "${aws_iam_role.autoscaling_role.id}"

  policy = "${data.aws_iam_policy_document.autoscaling_base_document.json}"
}