#!/bin/sh

CONF_DIR=$(realpath $(dirname $0))

install()
{
    if [ ! -f "$HOME/$1" ]
    then
        mkdir -p "$HOME/$(dirname $1)"
        cp -n "$CONF_DIR/tree/$1" "$HOME/$1"
        chmod 644 "$HOME/$1"
    fi
}

uninstall()
{
    true
}

case $1 in
    i) OP=install ;;
    u) OP=uninstall ;;
    *) exit 1 ;;
esac

for file in $(cd $CONF_DIR/tree; find . -type f | sed 's,^\./,,')
do $OP $file; done

