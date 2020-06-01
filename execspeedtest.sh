
!#/bin/bash

# execspeedtest.sh
$filename="/tmp/testresults.txt"
$hostfilename="/output/speedtesthistory.txt"

/usr/local/bin/speedtest-cli > "$filename"
cat "$filename" | grep 

