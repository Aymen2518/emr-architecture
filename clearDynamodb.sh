#!/bin/bash

TABLE_NAME=emr-demo
KEY=LockID

aws dynamodb scan --region eu-west-1 --table-name $TABLE_NAME --attributes-to-get "$KEY"   --query "Items[].$KEY.S" --output text |   tr "\t" "\n" |   xargs -t -I keyvalue aws dynamodb delete-item --table-name $TABLE_NAME   --key "{\"$KEY\": {\"S\": \"keyvalue\"}}" --region eu-west-1
