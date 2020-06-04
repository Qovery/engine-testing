FROM alpine
RUN apk add --update --no-cache mysql mysql-client socat && rm -f /var/cache/apk/*
ADD run.sh /
ENTRYPOINT ["/run.sh"]
