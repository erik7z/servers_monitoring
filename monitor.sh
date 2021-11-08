#!/bin/bash
export $(grep -v '^#' "`dirname $0`/.env" | xargs)

mapfile -t SERVERS_ARRAY < $SERVERS_LIST;

echo ":: $(date +'%D %T') :: Checking servers:";

for i in "${SERVERS_ARRAY[@]}"
do
  CHECKING_RESULT=$(curl -X HEAD -I "$i" 2>&1 | grep -o '200 OK' | grep -o 'OK');
  
  if [[ "$CHECKING_RESULT" == "OK" ]]; then
     ESCAPED_URL=$(sed 's:/:\\/:g' <<<$i)
     sed -i "/$ESCAPED_URL/d" $SERVERS_DOWN_LIST;
     echo "$i - $CHECKING_RESULT";
   else
      echo "$i - NOT OK, sending mail >>"; 
      bash $NOTIFY_SCRIPT "$i";
   fi

done;
