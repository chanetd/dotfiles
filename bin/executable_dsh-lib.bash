#!/bin/bash

platform_kermit_alias() {
    platform_short="$1"
    echo "${platform_short}-dsh"
}

platform_base_url() {
    platform_short="$1"
    if [ "$platform_short" = "prod" ] ; then
        echo "kpn-dsh.com"
    else
        echo "$platform_short.kpn-dsh.com"
    fi
}

ssh_credentials_dir() {
    platform_short="$1"
    echo "/tmp/credentials/${platform_short}"
}

ssh_fetch_credentials() {
    platform_short="$1"
    d=$(ssh_credentials_dir $platform_short)
    mkdir -p "$d"
    cd "$d"
    kermit fetch `platform_kermit_alias $platform_short`
    cd -
}

ssh_ensure_credentials() {
    platform_short="$1"
    force="$2" # leave empty if you don't want to force-fetch

    d=$(ssh_credentials_dir $platform_short)
    mkdir -p "$d"
    touch --date "6am" "$d/.today"
    if [ ! -z "$force" -o "$d/.today" -nt "$d/hosts.yml" ] ; then
        ssh_fetch_credentials $platform_short
    fi
}

node_canonical_type() {
    typ="$1"
    case "$typ" in
        m*)
            echo master
            ;;
        s*)
            echo private-slave
            ;;
        pr*)
            echo private-slave
            ;;
        pu*)
            echo public-slave
            ;;
        *)
            echo $typ
            ;;
    esac
}

node_kermit_type() {
    node_canonical="$1"
    case "$node_canonical" in
        "private-slave")
            echo private_slave
            ;;
        "public-slave")
            echo public_slave
            ;;
        *)
            echo "$node_canonical"
            ;;
    esac
}

node_yq_path() {
    local platform_short="$1"
    local node_type="$2"
    local index="${3:-0}"

    local ctype=`node_canonical_type $node_type`
    local ktype=`node_kermit_type $ctype`
    local kplatform=`platform_kermit_alias $platform_short`

    echo ".${ktype}.hosts[\"${kplatform}-${ctype}-${index}\"].ansible_host"
}

node_address() {
    local platform_short="$1"
    local node_type="$2"
    local index="${3:-0}"

    local d=`ssh_credentials_dir $platform_short`
    ssh_ensure_credentials $platform_short > /dev/null 2> /dev/null
    cat $d/hosts.yml | yq -r "$(node_yq_path $platform_short $node_type $index)"
}

node_ssh_args() {
    local platform_short="$1"
    local address="$2"
    
    ssh_ensure_credentials $platform_short > /dev/null 2> /dev/null
    echo "-F `ssh_credentials_dir $platform_short`/ssh.cfg centos@$address"
}

