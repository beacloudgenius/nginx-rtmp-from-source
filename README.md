https://www.nginx.com/blog/video-streaming-for-remote-learning-with-nginx/#configure

Build:

    docker build -t cloudgenius/nginx-rtmp-from-source:2020 .

Push:

    docker push cloudgenius/nginx-rtmp-from-source:2020

Run:

    docker run -it -p 1935:1935 -p 8080:80 --rm cloudgenius/nginx-rtmp-from-source:2020 bash

    /usr/local/nginx/sbin/nginx -g 'daemon off;'

    docker run -d -p 1935:1935 -p 8080:80 --rm cloudgenius/nginx-rtmp-from-source:2020

config:

    cp nginx.conf  /usr/local/nginx/conf

Test:

    /usr/local/nginx/sbin/nginx -t

    nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
    nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful

Ingest:

    ffmpeg -re -i /Volumes/cloudgenius/Recordings/2020\ 01\ Cloud/2020-01-13-0.mp4 -vcodec copy -loop -1 -c:a aac -b:a 160k -ar 44100 -strict -2 -f flv rtmp://localhost:1935/live/key

    ffmpeg -re -i /Volumes/cloudgenius/Recordings/2020\ 01\ Cloud/2020-01-13-0.mp4 -vcodec copy -loop -1 -c:a aac -b:a 160k -ar 44100 -strict -2 -f flv rtmp://hls.cloudgenius.app:1935/live/key

    ffmpeg -re \
        -i /stream/2016-09-13-Cloud-Tech.mp4 \
        -c:a copy -c:v copy \
        -f flv rtmp://stream:1935/live/key

TV Status:

production

    curl -X POST -H "Content-Type: application/json" https://backend.cloudgenius.app/TVstatus -d '{"secret":{"key":"sharedtoken"}, "TV":"started"}'

    curl -X POST -H "Content-Type: application/json" https://backend.cloudgenius.app/TVstatus -d '{"secret":{"key":"sharedtoken"}, "TV":"stopped"}'

localhost

    curl -X POST -H "Content-Type: application/json" http://imac.home.cloudgeni.us:3003/TVstatus -d '{"secret":{"key":"sharedtoken"}, "TV":"started"}'

    curl -X POST -H "Content-Type: application/json" http://imac.home.cloudgeni.us:3003/TVstatus -d '{"secret":{"key":"sharedtoken"}, "TV":"stopped"}'

RTMP:

    rtmp://localhost:1935/live/key
    rtmp://hls.cloudgenius.app:1935/live/key

HLS:

    http://localhost:8080/hls/key.m3u8
    http://localhost:8080/hls/key/index.m3u8
    https://hls.cloudgenius.app/hls/key.m3u8

DASH:

    http://localhost:8080/dash/key.mpd
    https://hls.cloudgenius.app/dash/key.mpd

players:

    https://github.com/amit08255/shaka-player-react-with-ui-config
    https://github.com/matvp91/shaka-player-react
    https://www.npmjs.com/package/shaka-player

    https://shaka-player-demo.appspot.com/docs/api/tutorial-welcome.html
    https://shaka-player-demo.appspot.com/docs/api/tutorial-basic-usage.html
    https://medium.com/@stepashka69/making-web-browser-play-streaming-video-mpeg-dash-smooth-streaming-hls-with-one-player-c5f4dd445b91#.nl6cz9yic
    https://www.wowza.com/testplayers

offline playback capability:

    https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API/Using_IndexedDB

DRM:

    https://pallycon.com/docs/en/getting-started/
    https://pallycon.com/docs/en/multidrm/clients/html5-player/
