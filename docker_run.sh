#!/bin/bash

#Script to execute the container

image=loopingspeedtester \
    && tag=latest \
    && loc="/c/temp/output" \
    && outdir="/output" \
    && TZ="America/New_York" \
    && docker run \
        -d \
        --env SECONDSTOSLEEPBETWEENITERATIONS=180 \
        --env DOCKERHOSTNAME=$HOSTNAME \
        --env TZ=$TZ \
        --name $image \
        --restart=unless-stopped \
        --mount type=bind,source="$loc",target="$outdir" \
        $image:$tag

