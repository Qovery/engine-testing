FROM alpine
RUN apk --update --no-cache add redis mini_httpd && rm -f /var/cache/apk/*
ADD run.sh /
ENTRYPOINT ["/run.sh"]
