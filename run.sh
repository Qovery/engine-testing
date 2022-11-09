#!/bin/sh

if [ ! -z $ENABLE_DEBUG ] ; then
    set -x
fi

if [ ! -z $DEBUG_PAUSE ] ; then
    sleep infinity
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

ensure_resquest_ok() {
  if $IS_ELASTICCACHE ; then
    echo "Trying connect to redis with TLS enabled"
    #redis-cli -u "redis://${REDIS_USERNAME}:${REDIS_PASSWORD}@${REDIS_HOST}:${REDIS_PORT}" --tls "info"
    redis-cli --tls -a "${REDIS_PASSWORD}" -h ${REDIS_HOST} -p ${REDIS_PORT} info
  else
    echo "Trying connect to redis"
    redis-cli -u "redis://${REDIS_USERNAME}:${REDIS_PASSWORD}@${REDIS_HOST}:${REDIS_PORT}" "info"
  fi

  if [ $? -ne 0 ] ; then
    echo "Error while trying to get redis info."
  fi
}

echo "Waiting for redis"
wait_for_redis
ensure_resquest_ok

echo "Everything work, open port 1234."
mini_httpd -D -d / -p 1234
