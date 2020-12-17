#!/bin/sh

if [ ! -z $ENABLE_DEBUG ] ; then
    set -x
fi

if [ ! -z $DEBUG_PAUSE ] ; then
    sleep infinity
fi

export PGPASSWORD=$PG_PASSWORD

echo "Waiting for postgres"
pg_isready -d $PG_DBNAME -h $PG_HOST -p $PG_PORT -U $PG_USERNAME

echo "Trying select 1"
psql -v ON_ERROR_STOP=1 --username $PG_USERNAME --dbname $PG_DBNAME -h $PG_HOST -c "select 1"
if [ $? -eq 0 ] ; then
    echo "Everything work, open port 1234."
    mini_httpd -D -d / -p 1234
fi
exit 1
