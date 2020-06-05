#!/bin/bash

#Script to execute the container
. ./docker_setvars.sh


hostype="$(uname -s)"
case "${hostype}" in
    Linux*)     hosttype=Linux;hostmountpoint=/tmp/output;;
    Darwin*)    hosttype=Mac;hostmountpoint=/tmp/output;;
    CYGWIN*)    hosttype=Cygwin;hostmountpoint="/c/temp/output";;
    MINGW*)     hosttype=MinGw;hostmountpoint="/c/temp/output";;  
    *)          hosttype="UNKNOWN:${unameOut}"
esac

echo "Executing on host type:  ${hosttype}  "
echo "The output files will be written to by the container in the directory:  ${hostmountpoint}"

if [ ${hosttype} = "Linux" ] 
    then if [ "$EUID" -ne 0 ]
        then echo "Both creating the mount directory and executing Docker requires running as root, and you are not... Exiting"
        exit
    fi
fi


[ ! -d  $hostmountpoint ] && mkdir $hostmountpoint

loc=${hostmountpoint} \
    && docker run \
        -d \
        --env SECONDSTOSLEEPBETWEENITERATIONS=180 \
        --env DOCKERHOSTNAME=$HOSTNAME \
        --env TZ=$TZ \
        --name $image \
        --restart=unless-stopped \
        --mount type=bind,source="$hostmountpoint",target="$outdir" \
        $image:$tag

