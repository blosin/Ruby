#!/bin/bash

writeCrontab (){
  [ $1 = 'x' ] && A='*' || A=$1
  [ $2 = 'x' ] && B='*' || B=$2
  [ $3 = 'x' ] && C='*' || C=$3
  [ $4 = 'x' ] && D='*' || D=$4
  [ $5 = 'x' ] && E='*' || E=$5

  echo $"$A $B $C $D $E bash /usr/src/redmine/bash/$6 $7 $8 $9 ${10}" >> text
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
  crontab -u redmine -l | grep -n $"$1 $2 $3 $4 $5"
}

CALL_FN=ttMailReminder.sh
DAYS=$(echo $6 | cut -d "_" -f 1)
TRACKER=$(echo $6 | cut -d "_" -f 2)
PROJECT=$(echo $6 | cut -d "_" -f 3)
USERS=$(echo $6 | cut -d "_" -f 4)

backupCrontab

if [[ -n $( checkCrontab $CALL_FN $DAYS $TRACKER $PROJECT $USERS ) ]]
then
  FILA=$( checkCrontab $CALL_FN | cut -d ":" -f 1 | cut -d " " -f 1 )
  crontab -u redmine -l | sed $"$FILA d"  > text
  writeCrontab $1 $2 $3 $4 $5 $CALL_FN $DAYS $TRACKER $PROJECT $USERS
else
  crontab -u redmine -l > text
  writeCrontab $1 $2 $3 $4 $5 $CALL_FN $DAYS $TRACKER $PROJECT $USERS
fi
