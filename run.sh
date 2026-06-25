#!/bin/sh

if [ ! -z "$ENABLE_DEBUG" ] ; then
    set -x
fi

if [ ! -z "$DEBUG_PAUSE" ] ; then
    sleep infinity
fi

# Wait until MySQL accepts our credentials. Uses the mysql client (present in every mysql image)
# rather than `nc -z`, whose flags differ between netcat-openbsd (Debian images) and nmap-ncat
# (the Oracle-Linux-based official 9.7 image).
wait_for_mysql() {
  for i in `seq 30` ; do
    echo "testing connection"
    if mysql -u "$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" -P "$MYSQL_PORT" -e "select 1" >/dev/null 2>&1 ; then
      echo "mysql is up"
      return
    fi
    echo "mysql not ready yet"
    sleep 2
  done
  echo "Operation Timeout"
  exit 1
}

# Serve a health endpoint on :1234. mini_httpd on the Debian-based images; python3 on the
# Oracle-Linux-based official image (9.7+), which has no mini-httpd package.
start_http_server() {
  if command -v mini_httpd >/dev/null 2>&1 ; then
    mini_httpd -D -d / -p 1234
  elif command -v python3 >/dev/null 2>&1 ; then
    python3 -m http.server 1234
  else
    echo "No HTTP server available" >&2
    exit 1
  fi
}

echo "Waiting for mysql"
wait_for_mysql

echo "Everything work, open port 1234."
start_http_server
exit 1
