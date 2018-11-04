FROM alpine:3.8

# Install Build Dependencies
RUN apk add --no-cache libmicrohttpd-dev jansson-dev openssl-dev \
  libsrtp-dev libcurl glib-dev opus-dev libogg-dev pkgconf gengetopt \
  libtool autoconf automake cmake libnice-dev libmicrohttpd-dev \
  lksctp-tools-dev libwebsockets-dev git gcc make g++ zlib-dev

# Install usrsctp
RUN git clone https://github.com/sctplab/usrsctp \
  && cd usrsctp && ./bootstrap && ./configure --prefix=/usr \
  && make && make install

# Install Janua Gateway
RUN git clone https://github.com/meetecho/janus-gateway.git \
  && cd janus-gateway && sh autogen.sh \
  && ./configure --prefix=/opt/janus \
  && make && make install && make configs
