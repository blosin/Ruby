#!/bin/bash

SELECTOR=$(echo $6 | cut -c 1-5)

case $SELECTOR in
allip)
FORMAT=$(echo $6 | cut -c 6-8)
bash /usr/src/redmine/bash/AIP_wrapper.sh $1 $2 $3 $4 $5 $FORMAT
;;
prjct)
FORMAT=$(echo $6 | cut -c 6-)
bash /usr/src/redmine/bash/PRJCT_wrapper.sh $1 $2 $3 $4 $5 $FORMAT
;;
issue)
ID=$(echo $6 | cut -c 6-)
bash /usr/src/redmine/bash/ITC_wrapper.sh $1 $2 $3 $4 $5 $ID
;;
sngpr)
ID=$(echo $6 | cut -c 6-)
bash /usr/src/redmine/bash/SNGPR_wrapper.sh $1 $2 $3 $4 $5 $ID
;;
bkrmf)
bash /usr/src/redmine/bash/RFB_wrapper.sh $1 $2 $3 $4 $5
;;
tmail)
OPTS=$(echo $6 | cut -c 6-)
bash /usr/src/redmine/bash/TMAIL_wrapper.sh $1 $2 $3 $4 $5 $OPTS
;;
*)
echo $'Not the case: \nInput: $1 $2 $2 $3 $4 $5 $6'
;;
esac
