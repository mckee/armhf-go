FROM mckee/armhf-ubuntu-core:vivid

ENV GOVERSION 1.4.2
ENV GOPATH /srv/go
ENV PATH ${GOPATH}/bin:/usr/local/go${GOVERSION}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y git build-essential && apt-get clean
RUN cd /usr/local && \
    git clone https://go.googlesource.com/go go${GOVERSION} && \
    cd go${GOVERSION} && \
    git checkout go${GOVERSION} && \
    cd src && \
    ./all.bash && \
    cd .. && \
    find . -name .git | xargs rm -rf && \
    mkdir -p /srv/go/src

ENTRYPOINT ["/usr/local/go${GOVERSION}/bin/go"]
CMD ["version"]

