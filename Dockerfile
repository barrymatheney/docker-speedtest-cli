FROM python:2-alpine
ARG  SECONDSTOSLEEPBETWEENITERATIONS=180
ARG  DOCKERHOSTNAME=DockerHostnameNotSet
ARG  TZ=America/New_York

ENV SECONDSTOSLEEPBETWEENITERATIONS=${SECONDSTOSLEEPBETWEENITERATIONS}
ENV DOCKERHOSTNAME=${DOCKERHOSTNAME}
ENV TZ=${TZ}

RUN pip install speedtest-cli
RUN apk update && apk upgrade && apk add bash 
RUN apk add --no-cache grep=3.3-r0
RUN apk add --update tzdata

WORKDIR work 
COPY . .

#ENTRYPOINT ["/usr/local/bin/speedtest-cli"]
ENTRYPOINT ["./execspeedtest.sh"]
  