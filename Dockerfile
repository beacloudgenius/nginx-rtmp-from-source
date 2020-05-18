FROM ubuntu:18.04

RUN mkdir /n
WORKDIR /n

RUN apt-get update && \
    apt-get install -y build-essential git libpcre3-dev libssl-dev zlib1g-dev && \
    git clone https://github.com/arut/nginx-rtmp-module.git && \
    git clone https://github.com/nginx/nginx.git && \
    cd nginx && \
    ./auto/configure --add-module=../nginx-rtmp-module && \
    make && \
    make install

ADD nginx.conf /usr/local/nginx/conf

CMD ["/usr/local/nginx/sbin/nginx"]
