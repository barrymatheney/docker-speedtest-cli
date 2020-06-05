#!/bin/bash

hostype="$(uname -s)"
case "${hostype}" in
    Linux*)     hosttype=Linux;;
    Darwin*)    hosttype=Mac;;
    CYGWIN*)    hosttype=Cygwin;;
    MINGW*)     hosttype=MinGw;;  
    *)          hosttype="UNKNOWN:${unameOut}"
esac

echo "Executing on host type:  ${hosttype}  "

if [ ${hosttype} = "Linux" ] 
    then if [ "$EUID" -ne 0 ]
        then echo "Both creating the mount directory and executing Docker require running as root, and you are not... Exiting"
        exit
    fi
fi



#Script to build the container locally
. ./docker_setvars.sh

docker build --rm -t $image:$tag -f Dockerfile  .  
