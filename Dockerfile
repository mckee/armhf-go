FROM mckee/armhf-ubuntu-core:vivid

ENV GOVERSION=1.5 GOPATH=/srv/go
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y git build-essential gccgo-5 && \
    cd /usr/local && \
    git clone https://go.googlesource.com/go go${GOVERSION} && \
    cd go${GOVERSION} && \
    git checkout go${GOVERSION} && \
    cd src && \
    ulimit -s 1024 && \
    GOROOT_BOOTSTRAP=/usr ./all.bash && \
    cd .. && \
    find . -name .git | xargs rm -rf && \
    apt-get remove -y git build-essential gccgo-5 && \
    apt-get autoremove -y && \
    apt-get clean && \
    mkdir -p /srv/go/src

ENV PATH ${GOPATH}/bin:/usr/local/go${GOVERSION}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENTRYPOINT ["go"]
CMD ["version"]


