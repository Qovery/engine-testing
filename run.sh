#!/bin/sh
#set -x

if [ ! -z "${APP_FILE_PATH_TO_BE_CHECKED2}" ] ; then
    echo "Error APP_FILE_PATH_TO_BE_CHECKED is not set"
    exit 1
fi

if [ ! -e "${APP_FILE_PATH_TO_BE_CHECKED}" ] ; then
    echo "Error: file $APP_FILE_PATH_TO_BE_CHECKED doesn't exists"
    exit 1
fi

while [ 1 ] ; do
    echo "File '$APP_FILE_PATH_TO_BE_CHECKED' exists"
    sleep 5
done
