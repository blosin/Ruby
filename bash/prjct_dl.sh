#!/bin/bash

IP=localhost
API_KEY="$(curl -X GET "http://$IP:4000/api_key/getKey?id=7c65e089fcde3396919f4897f95b9872653529daf52413f2032fdb4d3227f116" | cut -d ':' -f 2 | sed -r 's/.{3}$//'| sed 's/^.//')"
FILE_NAME=$(echo "/usr/src/redmine/files/downloads/proj_$2_issues$(date +%s).$1")

curl -v -H $"Content-Type: application/$1" -X GET --data-binary $"@issues.$1" \
	-H $"X-Redmine-API-Key: $API_KEY" http://$IP:4000/projects/$2/issues.$1 -o $FILE_NAME
