#!/usr/bin/env bash

# Load pywal colors
WAL="$HOME/.cache/wal/colors.sh"
[ -f "$WAL" ] && source "$WAL"

peaclock --config="
{
  \"time_format\": \"%H:%M:%S\",
  \"date_format\": \"\",
  \"show_date\": false,
  \"time_color\": \"${color5:-cyan}\",
  \"seconds\": true,
  \"box\": false
}
"

