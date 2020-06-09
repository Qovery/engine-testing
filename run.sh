#!/bin/sh

wait_for_mysql() {
  for i in `seq 20` ; do
    nc -z "$MYSQL_HOST" "$MYSQL_PORT" > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ] ; then
      return
    fi
    sleep 1
  done
  echo "Operation timed out" >&2
  exit 1
}


echo "Waiting for mysql"
wait_for_mysql

echo "Trying select 1"
mysql -u "$MYSQL_USERNAME" -p$MYSQL_PASSWORD -h $MYSQL_HOST -P$MYSQL_PORT $MYSQL_DBNAME -e "select 1"
if [ $? -eq 0 ] ; then
    echo "Everything work, open port 1234."
    mini_httpd -D -d / -p 1234
fi
exit 1
