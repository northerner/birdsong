#!/usr/bin/env bash

BIRD=`curl -L -I -s https://en.wikipedia.org/wiki/Special:RandomInCategory/Birds_of_Europe | grep 'location' | awk -F '/' '{ gsub("_", " "); print $NF }'`

echo $BIRD

URL=`curl -s https://www.xeno-canto.org/api/2/recordings?query=$BIRD | jq '.recordings[0].file' | awk '{ gsub("\"", ""); print substr($0,3) }'`

echo $URL
sleep .5

curl -L -s $URL --output birdaudio

afplay birdaudio
