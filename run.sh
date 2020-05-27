#!/bin/sh

pg_isready -d $PG_DBNAME -h $PG_HOST -p $PG_PORT -U $PG_USERNAME
if [ $? -eq 0 ] ; then
    sleep infinity
fi
