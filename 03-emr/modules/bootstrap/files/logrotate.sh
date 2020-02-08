#!/bin/sh

/usr/sbin/logrotate -f /etc/logrotate.d/emr
EXITVALUE=$?
if [ $EXITVALUE != 0 ]; then
    /usr/bin/logger -t logrotate-emr "ALERT exited abnormally with [$EXITVALUE]"
fi
exit 0
