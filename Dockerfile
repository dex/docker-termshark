FROM alpine:edge
MAINTAINER Dex Chen
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && apk add termshark
ENTRYPOINT termshark
