#!/bin/sh

export PGPASSWORD=$PG_PASSWORD

pg_isready -d $PG_DBNAME -h $PG_HOST -p $PG_PORT -U $PG_USERNAME

psql -v ON_ERROR_STOP=1 --username $PG_USERNAME --dbname $PG_DBNAME -h $PG_HOST
if [ $? -eq 0 ] ; then
    sleep infinity
fi
