#!/bin/bash

# https://backend.cloudgenius.app/TVstatus \
# http://imac.home.cloudgeni.us:3003/TVstatus \

input_file=$1
video_filename=$2

# Define the location that the publicly accessible mp4 files will be served from

output=/n/rec/$2;

echo 0 > /stream/isrunning
curl  -X POST \
      -H "Content-Type: application/json" \
      https://backend.cloudgenius.app/TVstatus \
      -d '{
            "secret": {
              "key": "sharedtoken"
            },
          "TV": "stopped"
          }'
