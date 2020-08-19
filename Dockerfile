ARG GO_VER=1.14.4
ARG ALPINE_VER=3.12
ARG PORT

FROM alpine:${ALPINE_VER} as peer-base
RUN apk add --no-cache tzdata
# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/golang/go/blob/go1.9.1/src/net/conf.go#L194-L275
# - docker run --rm debian:stretch grep '^hosts:' /etc/nsswitch.conf
RUN echo 'hosts: files dns' > /etc/nsswitch.conf

FROM golang:${GO_VER}-alpine${ALPINE_VER} as golang
RUN apk add --no-cache \
	bash \
	gcc \
	git \
	make \
	musl-dev
ADD . $GOPATH/src/github.com/yoseplee/helloworld
WORKDIR $GOPATH/src/github.com/yoseplee/helloworld/server

FROM golang as peer
RUN go build .

FROM peer-base
COPY --from=peer /go/src/github.com/yoseplee/helloworld/server /usr/local/bin
EXPOSE ${PORT}
CMD ["server"]