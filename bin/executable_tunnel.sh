#!/bin/bash

set -x

usage() {
    cat <<EOF
Usage: $(basename $0) [-p <platform>] [-n <port>] [-r]

    -p platform: {dev|staging|poc|prod|loadtest} (default = dev)
    -n port: local port for admin UI forwarding (default = 8080)
    -r: force credentials refresh
EOF
    exit 0
}

PLATFORM=dev
PORT=8080
FORCE_REFRESH=no

while getopts ":hrp:n:" opt ; do
    case "$opt" in
        h|\?)
            usage
            ;;
        p)
            PLATFORM="$OPTARG"
            ;;
        n)
            PORT="$OPTARG"
            ;;
        r)
            FORCE_REFRESH=yes
            ;;
        *)
            usage
            ;;
    esac
done

CREDENTIALS_DIR=/tmp/credentials/$PLATFORM
PLATFORM_ALIAS=${PLATFORM}-dsh

ensure_credentials() {
    mkdir -p $CREDENTIALS_DIR
    cd $CREDENTIALS_DIR
    touch --date "6am" .today
    if [ $FORCE_REFRESH = "yes" -o ! -f hosts.yml -o .today -nt hosts.yml ] ; then
        kermit fetch $PLATFORM_ALIAS
    fi
    cd -
}

ensure_credentials

ssh $(yq -r '[.master.hosts[]]|.[1].ansible_host' ${CREDENTIALS_DIR}/hosts.yml) -F ${CREDENTIALS_DIR}/ssh.cfg -L ${PORT}:localhost:80
