#!/bin/sh

curl -s -F "name=eicar" -F "file=@test/safe.txt" "$1/v1alpha/scan" -o /dev/null -w "%{http_code}" | grep -q "200"
