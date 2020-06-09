FROM bitnami/mongodb:4.2.7-debian-10-r20
USER root
RUN apt-get update && apt-get -y install mini-httpd netcat-openbsd
USER 1001
COPY rds-combined-ca-bundle.pem run.sh insert.json select.json /
WORKDIR /
CMD ["/run.sh"]
