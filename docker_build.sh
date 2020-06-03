#!/bin/bash

#Script to build the container locally

image=loopingspeedtester && \
    tag=latest && \
    docker build --rm -t $image:$tag -f Dockerfile  .
