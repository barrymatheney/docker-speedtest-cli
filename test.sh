#!/bin/sh

# host we want to "reach"
host=google.com

# get the ip of that host (works with dns and /etc/hosts. In case we get  
# multiple IP addresses, we just want one of them
host_ip=$(getent ahosts "$host" | awk '{print $1; exit}')

# only list the interface used to reach a specific host/IP. We only want the part
# between dev and src (use grep for that)
ip route get "$host_ip" | grep -Po '(?<=(dev )).*(?= src| proto)'
