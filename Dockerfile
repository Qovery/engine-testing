FROM public.ecr.aws/r3m4q3r9/pub-mirror-debian:11.6
RUN apt-get update && apt-get install -y pkg-config libssl-dev ca-certificates && rm -rf /var/lib/apt/lists/*
ADD run.sh /
CMD ["/run.sh"]
