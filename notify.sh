#!/bin/bash

ALREADY_SENT=$(grep -c $1 $SERVERS_DOWN_LIST)

if [[ "$ALREADY_SENT" == "1" ]]; then
  echo "ALREADY SENT > SKIPPING...";
else 
  echo "Webservice $1 is not available" | mail -s "MONITORING: $1 is down" $MESSAGE_TO;
  echo $1 >> $SERVERS_DOWN_LIST;
  echo "MAIL SENT TO: $1";
fi;
