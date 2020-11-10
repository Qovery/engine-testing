FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
COPY . .
RUN go get -d -v
RUN go build -o /go/bin/http-echo

FROM alpine

COPY --from=builder /go/bin/http-echo /go/bin/http-echo
ENV ECHO_TEXT=
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
CMD ["/go/bin/http-echo"]
