#!/bin/sh

CONF_DIR=$(realpath `dirname $0`)

mkdir -p $HOME/bin/
ln -sf $CONF_DIR/scripts $HOME/bin/xdf
