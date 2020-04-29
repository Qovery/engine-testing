FROM python:3-alpine
RUN pip install flask pymongo
COPY app.py /
COPY rds-combined-ca-bundle.pem /
WORKDIR /
ENV FLASK_APP /app.py
ENTRYPOINT ["flask", "run", "-h", "0.0.0.0", "-p", "80"]
EXPOSE 80
