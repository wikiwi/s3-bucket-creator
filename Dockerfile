FROM alpine

RUN apk add --update \
    bash \
    ca-certificates \
    openssl \
    wget

RUN wget -q -O /etc/apk/keys/andyshinn.rsa.pub https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/andyshinn.rsa.pub && \
    wget https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r1/glibc-2.23-r1.apk && \
    apk add glibc-2.23-r1.apk

RUN wget -O /usr/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc && \
    chmod +x /usr/bin/mc

COPY run.sh /sbin/run.sh
RUN chmod 755 /sbin/run.sh

ENTRYPOINT ["/bin/bash"]
CMD ["/sbin/run.sh"]

