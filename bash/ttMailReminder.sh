#!/bin/bash

[ $1 = 'X' ] && DAYS='' || DAYS="days=$1"
[ $2 = 'X' ] && TRACKER='' || TRACKER="tracker=$2"
[ $3 = 'X' ] && PROJECT='' || PROJECT="project=$3"
[ $4 = 'X' ] && USERS='' || USERS="users=$4"

cd /usr/src/redmine
bundle exec rake redmine:send_reminders $DAYS $TRACKER $PROJECT $USERS RAILS_ENV="production"
cd -
