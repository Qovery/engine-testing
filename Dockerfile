FROM alpine
RUN apk --update --no-cache add mini_httpd && rm -f /var/cache/apk/*
ADD run.sh /
ADD . /root
EXPOSE 1234
ENTRYPOINT ["/run.sh"]
