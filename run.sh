#!/bin/sh

if [ ! -z $ENABLE_DEBUG ] ; then
    set -x
fi

if [ ! -z $DEBUG_PAUSE ] ; then
    sleep infinity
fi

wait_for_mysql() {
  for i in `seq 20` ; do
    echo "testing connection"
    nc -z -v -w5 $MYSQL_HOST $MYSQL_PORT
    result1=$?
    if [  "$result1" != 0 ]; then
      echo  'port $MYSQL_PORT is closed'
      sleep 1
    else
      echo 'port $MYSQL_PORT is open'
      return
    fi
  done
  echo "Operation Timeout"
  exit 1
}


echo "Waiting for mysql"
wait_for_mysql

echo "Trying select 1"
mysql -u "$MYSQL_USERNAME" -p$MYSQL_PASSWORD -h $MYSQL_HOST -P$MYSQL_PORT -e "select 1"
if [ $? -eq 0 ] ; then
    echo "Everything work, open port 1234."
    mini_httpd -D -d / -p 1234
fi
exit 1
