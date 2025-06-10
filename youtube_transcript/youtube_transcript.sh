#!/bin/bash

# Dependancies:
# jq
# yt-dlp
# yt-dlp --help shows all the options by default

if ! command -v yt-dlp >/dev/null; then
  echo "Dependancies not available"
  exit 1
fi

if [ $# -ne 1 ]; then
  echo "Usage: this command takes in only 1 argument"
  exit 1
fi

yt_url="$1"
subs_available=$(yt-dlp --list-subs "$yt_url" 2>/dev/null | grep "en")

#yt-dlp [OPTIONS] [--] URL [URL...]

if [[ -z "$subs_available" ]]; then
  echo "There are no english subs abailable"
  exit 1
else
  yt-dlp --skip-download \
    --write-subs \
    --write-auto-subs \
    --sub-lang "en" \
    --sub-format json3 \
    -o "yt_url_transcript.%(ext)s" \
    "$yt_url"
fi

jq -r '
    .events[].segs?[]?.utf8
' yt_url_transcript.en.json3 |
  tee Official_transcript.txt >/dev/null

# Pipelining in this case is pretty useless and could be replaced with >, however I enjoy using it.

title=$(yt-dlp -e "$yt_url")

echo -e "\n\n ====Video_Title====" >>Official_transcript.txt
echo "$title" >>"Official_transcript.txt"

rm yt_url_transcript.en.json3
