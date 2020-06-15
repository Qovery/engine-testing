#!/bin/sh

if [ ! -z $ENABLE_DEBUG ] ; then
    set -x
fi

wait_for_redis() {
  for i in `seq 20` ; do
    nc -z "$REDIS_HOST" "$REDIS_PORT" > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ] ; then
      return
    fi
    sleep 1
  done
  echo "Operation timed out" >&2
  exit 1
}


echo "Waiting for redis"
wait_for_redis


echo "Trying connect to redis"
redis-cli -u "redis://redis:${REDIS_PASSWORD}@${REDIS_HOST}:${REDIS_PORT}" "info"
if [ $? -eq 0 ] ; then
    echo "Everything work, open port 1234."
    mini_httpd -D -d / -p 1234
fi
exit 1
