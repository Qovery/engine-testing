FROM public.ecr.aws/r3m4q3r9/pub-mirror-alpine:3.20.2
RUN apk --update --no-cache add postgresql mini_httpd && rm -f /var/cache/apk/*
ADD run.sh /
EXPOSE 1234
ENTRYPOINT ["/run.sh"]
