
!#/bin/bash

# execspeedtest.sh
filename="/tmp/testresults.txt"

filename="./sample.txt"

hostfilename="/output/speedtesthistory.txt"
pipechar="|"
################################/usr/local/bin/speedtest-cli > "$filename"
lineout=$(date +%Y%m%d_%H%M%S)
echo $lineout

#get the source IP from the output
val=""
val=$(grep  'Testing from ' $filename) 
val=$(echo $val | grep -Po '(?<=\().*(?=\))')
lineout=$lineout$pipechar$val

#get the destination host info provided
val=""
srch='Hosted by '
val=$(grep  "$srch" $filename) 
charstosave=`expr ${#val} - ${#srch}`
echo $charstosave
val=${val: -$charstosave}
echo $val
lineout=$lineout$pipechar$val
echo $lineout


#get the Down speed
val=""
srch='Download: '
val=$(grep  "$srch" $filename) 
charstosave=`expr ${#val} - ${#srch}`
echo $charstosave
val=${val: -$charstosave}
echo $val
lineout=$lineout$pipechar$val
echo $lineout

#get the u[] speed
val=""
srch='Upload: '
val=$(grep  "$srch" $filename) 
charstosave=`expr ${#val} - ${#srch}`
echo $charstosave
val=${val: -$charstosave}
echo $val
lineout=$lineout$pipechar$val
echo $lineout
