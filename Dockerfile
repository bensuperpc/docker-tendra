ARG DOCKER_IMAGE=ubuntu:20.04
FROM $DOCKER_IMAGE AS builder

ARG DEBIAN_FRONTEND=noninteractive

ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386
RUN apt update -y -q && apt dist-upgrade -y -q && apt update -y -q
RUN apt install -y -q \
    pmake \
	bmake \
    g++ \
    gcc \
    gcc-multilib \
    libc6-dev-i386 \
    linux-libc-dev \
	git \
	&&	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone --recurse-submodules --remote-submodules  https://github.com/tendra/tendra.git
WORKDIR /tendra

RUN git checkout e21a210d906329ddf6d3889b1dbb5a8a9b5c78a5

RUN bmake -r CC=gcc TARGETARCH=x32_64

LABEL author="Bensuperpc <bensuperpc@gmail.com>"
LABEL mantainer="Bensuperpc <bensuperpc@gmail.com>"

ARG VERSION="1.0.0"
ENV VERSION=$VERSION

ENV PATH="/tendra/obj.buildkitsandbox-bootstrap/bin:${PATH}"
ENV CC=/tendra/obj.buildkitsandbox-bootstrap/bin/tcc

WORKDIR /tendra/obj.buildkitsandbox-bootstrap/bin

RUN tcc -V

RUN ln -s /usr/lib32 /usr/lib/i386-linux-gnu

WORKDIR /usr/src/myapp

CMD ["tcc", "-V"]

LABEL org.label-schema.schema-version="1.0" \
	  org.label-schema.build-date=$BUILD_DATE \
	  org.label-schema.name="bensuperpc/tendra" \
	  org.label-schema.description="build tendra compiler" \
	  org.label-schema.version=$VERSION \
	  org.label-schema.vendor="Bensuperpc" \
	  org.label-schema.url="http://bensuperpc.com/" \
	  org.label-schema.vcs-url="https://github.com/Bensuperpc/docker-tendra" \
	  org.label-schema.vcs-ref=$VCS_REF \
	  org.label-schema.docker.cmd="docker build -t bensuperpc/tendra -f Dockerfile ."
