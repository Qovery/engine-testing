FROM alpine
RUN apk --update --no-cache add postgresql mini_httpd && rm -f /var/cache/apk/*
ADD run.sh /
EXPOSE 1234
ENTRYPOINT ["/run.sh"]
