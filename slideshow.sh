#!/bin/bash
PHOTOS=/srv/photos

while true; do
  mpv --vo=drm --fs --no-osc --no-osd-bar \
      --image-display-duration=30 --shuffle \
      --loop-playlist=inf "$PHOTOS" &
  MPV_PID=$!

  inotifywait -r -e create,delete,moved_to,moved_from "$PHOTOS"

  kill $MPV_PID 2>/dev/null
  sleep 1
done
