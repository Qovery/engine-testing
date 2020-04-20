FROM python:3-alpine
RUN pip install flask pymongo
COPY app.py /
ENV FLASK_APP /app.py
ENTRYPOINT ["flask", "run", "-h", "0.0.0.0", "-p", "80"]
EXPOSE 80
