#!/bin/bash
# https://backend.cloudgenius.app/TVstatus \
# http://imac.home.cloudgeni.us:3003/TVstatus \

sleep 14
echo 1 > /stream/isrunning
curl  -X POST \
      -H "Content-Type: application/json" \
      https://backend.cloudgenius.app/TVstatus \
      -d '{
          "secret":  {
            "key": "sharedtoken"
          },
          "TV": "started"
        }'
