FROM python:2-alpine
RUN pip install speedtest-cli
RUN apk update && apk upgrade && apk add bash 


ENTRYPOINT ["/usr/local/bin/speedtest-cli"]
