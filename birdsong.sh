#!/usr/bin/env bash

BIRD=`curl -L -I -s https://en.wikipedia.org/wiki/Special:RandomInCategory/Birds_of_Europe\
  | grep 'location'\
  | awk -F '/' '{ gsub("_", " "); print $NF }'`

echo $BIRD

URL=`curl -s https://www.xeno-canto.org/api/2/recordings?query=$BIRD | jq '.recordings[0].file'`

URL=${URL//\"/}
URL=${URL:2}

echo $URL
sleep .2

curl -L -s $URL --output birdaudio

if [ -x "$(command -v paplay)" ]; then
  paplay birdaudio
elif [ -x "$(command -v afplay)" ]; then
  afplay birdaudio
fi
