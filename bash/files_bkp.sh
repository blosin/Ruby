#!/bin/bash

FILE_NAME="ttt-files$(date +%F).tar.gz"
CMMD="tar -czvf $FILE_NAME"
BASE="/usr/src/redmine/files/"

cd /usr/src/redmine/files
bash -c "$CMMD $BASE"
mv $BASE$FILE_NAME /usr/src/backups/
cd -
