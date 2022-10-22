FROM ubuntu:latest
RUN apt update
RUN apt install python3 -y
COPY webserver.py ./
EXPOSE 8000

CMD ["python3","./webserver.py"]
