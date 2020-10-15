#!/bin/sh

DMENU_PROMPT=Word
DMENU_LINES=10
DMENU_COLUMNS=3

HISTORY_FILE="$SDCV_HISTFILE"

INPUT=$(tac "$HISTORY_FILE" | uniq | dmenu -p "$DMENU_PROMPT" -l $DMENU_LINES -g $DMENU_COLUMNS)
[ -z "$INPUT" ] && exit

OUTPUT_FILE=$(mktemp -p /tmp --suffix=.html dictionary.XXXXXXXX)
sdcv.sh "$INPUT" > "$OUTPUT_FILE"

tabbed-st.sh info_dictionary -e less "$OUTPUT_FILE"

