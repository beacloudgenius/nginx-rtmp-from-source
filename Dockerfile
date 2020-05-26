FROM ubuntu:18.04

RUN mkdir /n
WORKDIR /n

RUN apt-get update && \
    apt-get install -y build-essential git libpcre3 libpcre3-dev libssl-dev zlib1g-dev && \
    git clone --branch v1.2.1 --depth 1 https://github.com/arut/nginx-rtmp-module.git && \
    git clone --branch master --depth 1 https://github.com/nginx/nginx.git && \
    cd nginx && \
    ./auto/configure --with-http_ssl_module --add-module=../nginx-rtmp-module && \
    make -j 4 && \
    make install

RUN apt-get install -y htop tree vim curl
RUN apt-get install -y ffmpeg

RUN mkdir -p /n/logs /n/rec /stream

# Remember to chown -R www-data:www-data /stream
# Remember to copt nginx.conf and mime.types to /stream

# ADD nginx.conf /usr/local/nginx/conf
# ADD nginx.conf /stream
# ADD mime.types /stream

ADD static /n/static
ADD public /n/public
RUN rm -rf /n/nginx /n/nginx-rtmp-module /usr/local/nginx/conf/nginx.conf
RUN chown -R www-data:www-data /n
ENV PATH="/usr/local/nginx/sbin/:${PATH}"

CMD ["/usr/local/nginx/sbin/nginx", "-c", "/stream/nginx.conf", "-g", "daemon off;"]
