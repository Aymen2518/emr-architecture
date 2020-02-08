# General configuration

aws_profile             = "xxxxxxx"

remote_state_workspace  = "xxxxxx"

team                    = "xxxxx"

az                      = "a"

region                  = "eu-west-1"

instance_name           = "t3.micro"

instance_count          = 1

customer                = "emr"

project                 = "emr-demo"


hosted_zone_id          = "xxxxxx"

dns_suite               = "alamara-labs.com"

acm_arn                 = "xxxxxxxxxxxxxxxxxxxx"

# EMR configuration

master_instance_type    = "m4.xlarge"

master_instance_count_min = 1

core_instance_type      = "m4.xlarge"

core_instance_count_min = 1

core_instance_count_max = 15

emr_release             = "emr-5.21.0"

core_volume_size        = 100 # The size (in GB)

root_volume_size        = 100  # The size (in GB)

# Settings for emr jobs

applications            = ["Spark", "Hadoop", "Hive", "Sqoop", "Livy"]


