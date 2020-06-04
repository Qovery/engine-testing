FROM alpine
RUN apk --update --no-cache add postgresql socat && rm -f /var/cache/apk/*
ADD run.sh /
ENTRYPOINT ["/run.sh"]
