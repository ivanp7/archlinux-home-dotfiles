#!/bin/sh

PASSWORD_STORE=$HOME/.password-store

DMENU_PROMPT=Password
DMENU_LINES=10

cd $PASSWORD_STORE

export PINENTRY_USER_DATA=X
find . -path "./.git" -prune -o -type f -name "*.gpg" -print |
    sed 's@^\./@@; s@\.gpg@@' |
    dmenu -fn "$DEFAULT_FONT" -p "$DMENU_PROMPT" -l $DMENU_LINES | 
    xargs -r pass -c
