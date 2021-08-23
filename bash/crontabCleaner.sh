#!/bin/bash

FILA=$((1+$1))
crontab -u redmine -l | sed $"$FILA d"  > text
cat text | crontab -u redmine -
rm text
echo "Crontab updated and running"
