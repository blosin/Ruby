#!/bin/bash

writeCrontab (){
  [ $1 = 'x' ] && A='*' || A=$1
  [ $2 = 'x' ] && B='*' || B=$2
  [ $3 = 'x' ] && C='*' || C=$3
  [ $4 = 'x' ] && D='*' || D=$4
  [ $5 = 'x' ] && E='*' || E=$5

  echo $"$A $B $C $D $E bash /usr/src/redmine/bash/$6 $7 $8" >> text
  cat text | crontab -u redmine -
  rm text
  echo "Crontab updated and running"
}

backupCrontab (){
  FILE_NAME=$(echo "cron_backup$(date +%s)")
  crontab -u redmine -l > /usr/src/redmine/files/crontabBackUps/$FILE_NAME
  echo "Backup file created"
}

checkCrontab (){
  crontab -u redmine -l | grep -n $"$1 $2 $3"
}

CALL_DL=issues_dl.sh
FORMAT=$(echo $6 | cut -c 1-3)
ISSUE_ID=$(echo $6 | cut -c 4-)

backupCrontab

if [[ -n $( checkCrontab $CALL_DL $FORMAT $ISSUE_ID ) ]]
then
  FILA=$( checkCrontab $CALL_DL $FORMAT $ISSUE_ID | cut -d ":" -f 1 | cut -d " " -f 1 )
  crontab -u redmine -l | sed $"$FILA d"  > text
  writeCrontab $1 $2 $3 $4 $5 $CALL_DL $FORMAT $ISSUE_ID
else
  crontab -u redmine -l > text
  writeCrontab $1 $2 $3 $4 $5 $CALL_DL $FORMAT $ISSUE_ID
fi
