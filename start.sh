#!/bin/bash

set -e
set -u
set -o pipefail

pushd /etc/icecast2

if [ ! -f icecast.xml.bak ]; then
    cp icecast.xml icecast.xml.bak
fi

cat /etc/icecast.xml.noconfig | \
    sed "s/SOURCE_PASSWORD/$SOURCE_PASSWORD/g" | \
    sed "s/RELAY_PASSWORD/$RELAY_PASSWORD/g" | \
    sed "s/ADMIN_PASSWORD/$ADMIN_PASSWORD/g" | \
    sed "s/HOSTNAME/$SERVERNAME/g" | \
    sed "s/LISTEN_ADDRESS/$LISTEN_ADDRESS/g" | \
    cat > icecast.xml

exec /usr/bin/icecast2 -c /etc/icecast2/icecast.xml
