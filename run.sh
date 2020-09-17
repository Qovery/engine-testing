#!/bin/sh

echo "Checking submodule is present"
if [ -f /root/sub/Dockerfile ] ; then
    echo "Everything works, opening port 1234."
    mini_httpd -D -d / -p 1234
fi
exit 1
