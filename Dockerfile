FROM hashicorp/http-echo 
EXPOSE 5678
ENTRYPOINT ["/http-echo", "-text='hello world'"]
