https://www.nginx.com/blog/video-streaming-for-remote-learning-with-nginx/#configure

Build:
    docker build -t cloudgenius/nginx-rtmp-from-source:2020 .

Push:
    docker push cloudgenius/nginx-rtmp-from-source:2020

Config:

    cp nginx.conf  /usr/local/nginx/conf

Test:

    /usr/local/nginx/sbin/nginx -t

    nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
    nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful

Ingest

    ffmpeg -re \
        -i /Volumes/cloudgenius/Recordings/2020\ 01\ Cloud/2020-01-13-0.mp4 \
        -vcodec copy -loop -1 -c:a aac -b:a 160k -ar 44100 -strict -2 \
        -f flv rtmp://localhost:1935/live/key

RTMP
    rtmp://localhost:1935/live/key

HLS
    http://localhost:8080/hls/key.m3u8

DASH
    http://localhost:8080/dash/key.mpd
