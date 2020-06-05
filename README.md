# This was a FORK of:  moutten/speedtest-cli.


## The original speedtest allowed a single execution of the commands.  

## Changes in this version from the original:
    Allows for the image to run constantly and capture logs over long duration in order to capture 
    variation and degredation patterns in IO over time.

    Faciliates "no scheduler" as it simply sleeps for the duration that you set as a parameter to the execution
    
    Has a rolling daily log process that allows for simple log management.

## TO DO LIST
1.  Add Powershell scripts to allow script build and execution on non-Mingw Windows Hosts
2.  Modify the docker_run.sh to complete MAC variabe substitution.

## Build and run locally from the docker file

If you want to build the docker container image yourself you can do so with the
following commands:

Modify ./docker_setvars.sh as necessary to change build and runtime docker variables.

```bash

git clone git@github.com:barrymatheney/docker-speedtest-cli.git
cd docker-speedtest-cli

BUILD:  ./docker_build.sh
RUN:    ./docker_run.sh

```bash
