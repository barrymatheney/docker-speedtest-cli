FROM python:2-alpine
ARG  SECONDSTOSLEEPBETWEENITERATIONS=180

ENV SECONDSTOSLEEPBETWEENITERATIONS=${SECONDSTOSLEEPBETWEENITERATIONS}
RUN pip install speedtest-cli
RUN apk update && apk upgrade && apk add bash 
RUN apk add --no-cache grep=3.3-r0

WORKDIR work 
COPY . .

#ENTRYPOINT ["/usr/local/bin/speedtest-cli"]
ENTRYPOINT ["./execspeedtest.sh"]
