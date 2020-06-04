# This was a FORK of:  moutten/speedtest-cli.


## The original speedtest allowed a single execution of the commands.  

## Changes in this version:
    Allows for the image to run constantly and capture logs over long duration in order to capture variation and degredation patterns in IO
    Faciliates "no scheduler" as it simply sleeps for the duration that you set as a parameter to the execution
    Has a rolling daily log process that allows for simple log management.


### Build from docker file

If you want to build the docker container image yourself you can do so with the
following commands:

```bash
git clone git@github.com:barrymatheney/docker-speedtest-cli.git
cd docker-speedtest-cli

image=loopingspeedtester && \
    tag=latest && \
    docker build --rm -t $image:$tag -f Dockerfile  .

```
### Running the command line tool

```bash

#### RUN with the TZ variable.  
#YOU Must set the TZ Environment variable on Windows if you want to pass it in, otherwise the Dockerfile includes a default.  Passing NULL sets UTC
image=loopingspeedtester \
    && tag=latest \
    && loc="/c/temp/output" \
    && outdir="/output" \
    && docker run \
        -d \
        --env SECONDSTOSLEEPBETWEENITERATIONS=180 \
        --env DOCKERHOSTNAME=$HOSTNAME \
        --env TZ=$TZ \  
        --name $image \
        --restart=unless-stopped \
        --mount type=bind,source="$loc",target="$outdir" \
        $image:$tag


#### RUN WITHOUT the TZ variable.  
image=loopingspeedtester \
    && tag=latest \
    && loc="/c/temp/output" \
    && outdir="/output" \
    && docker run \
        -d \
        --env SECONDSTOSLEEPBETWEENITERATIONS=180 \
        --env DOCKERHOSTNAME=$HOSTNAME \
        --name $image \
        --restart=unless-stopped \
        --mount type=bind,source="$loc",target="$outdir" \
        $image:$tag


```



More README.MD to come...