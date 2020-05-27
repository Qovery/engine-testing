FROM alpine
RUN apk -U --no-cache add postgresql
ADD run.sh /
ENTRYPOINT ["/run.sh"]
