#!/bin/bash

# http://tldp.org/LDP/abs/html/options.html
set -o errexit
set -o nounset

#### LOGROTATE ####
aws s3 cp s3://${bootstrap_bucket}/logrotate /tmp/
sudo -u root cp /tmp/logrotate /etc/logrotate.d/emr
sudo -u root chmod 0644 /etc/logrotate.d/emr

aws s3 cp s3://${bootstrap_bucket}/logrotate.sh /tmp/
sudo -u root cp /tmp/logrotate.sh /etc/cron.hourly/logrotate-emr
sudo -u root chmod 0755 /etc/cron.hourly/logrotate-emr

#### SYSLOG ####
aws s3 cp s3://${bootstrap_bucket}/syslog.conf /tmp/
sudo -u root cp /tmp/syslog.conf /etc/rsyslog.d/25-emr.conf
sudo -u root chmod 0644 /etc/rsyslog.d/25-emr.conf
sudo -u root service rsyslog restart
