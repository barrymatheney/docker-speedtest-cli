#!/bin/bash

#Script to build the container locally
. ./docker_setvars.sh

docker build --rm -t $image:$tag -f Dockerfile  .  
