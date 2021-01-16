#!/bin/sh

TYPE=$1
shift 1

VIDEO_FLAGS=""
AUDIO_FLAGS=""

SOUND_FLAGS="-f pulse -i 0 -acodec aac"
MIC_FLAGS="-f alsa -i hw:0 -acodec aac -strict -2 -ac 1"

case $TYPE in
    screen*)
        AREA=$1
        shift 1

        case $AREA in
            "#")
                SCREEN=$(monitor-info.sh | head -2)
                SCREEN_SIZE=$(echo "$SCREEN" | head -1)
                SCREEN_DISPL=$(echo "$SCREEN" | tail -1)

                SIZE="${SCREEN_SIZE% *}x${SCREEN_SIZE#* }"
                DISPL="+${SCREEN_DISPL% *},${SCREEN_DISPL#* }"

                DIRECTORY="screencast/full"
                ;;
            *)
                [ "$AREA" = "+" ] && AREA=$(slop)

                SIZE=${AREA%%+*}
                AREA=${AREA#*+}
                DISPL="+${AREA%+*},${AREA#*+}"

                DIRECTORY="screencast/area"
        esac

        FILENAME_PREFIX="screencast"
        FILENAME_EXT="mp4"

        if command -v nvidia-smi > /dev/null && [ "$(nvidia-smi -L | wc -l)" -gt 0 ]
        then VIDEO_CODEC=h264_nvenc
        fi

        VIDEO_FLAGS="-f x11grab -r 30 -s $SIZE -i ${DISPLAY}${DISPL} -vcodec ${VIDEO_CODEC:-libx264}"

        case $TYPE in
            *mic)
                AUDIO_FLAGS="$MIC_FLAGS"
                DIRECTORY="$DIRECTORY/mic"
                ;;
            *)
                AUDIO_FLAGS="$SOUND_FLAGS"
                DIRECTORY="$DIRECTORY/sound"
                ;;
        esac
        ;;

    mic)
        DIRECTORY="microphone"

        FILENAME_PREFIX="record"
        FILENAME_EXT="aac"

        AUDIO_FLAGS="$MIC_FLAGS"
        ;;
esac

FILENAME="${FILENAME_PREFIX}_$(date "+%F_%T").${FILENAME_EXT}"

mkdir -p "$HOME/capture/$DIRECTORY"
ffmpeg -y "$@" $AUDIO_FLAGS $VIDEO_FLAGS "$HOME/capture/$DIRECTORY/$FILENAME"

