#!/bin/bash
while [ 1 ]
echo "ENV Variables:"
echo "      SECONDSTOSLEEPBETWEENITERATIONS:$SECONDSTOSLEEPBETWEENITERATIONS"
echo "                       DOCKERHOSTNAME:$DOCKERHOSTNAME"
echo "                                   TZ:$TZ"

do
    echo "starting at:  $(date +%Y%m%d_%H%M%S)"   
    # execspeedtest.sh
    datestampforfilename=$(date +%Y%m%d)
    execlocaloutputfilename="/tmp/speedtestresults.txt"  
    echo $execlocaloutputfilename 

    #execlocaloutputfilename="./sample.txt"
    outputdir=/output
    #make the directory if it doesn't exist... IT SHOULD as it should be mounted to the container for host output.
    [ ! -d $outputdir ] && mkdir $outputdir
    outputfilename="$outputdir"/$datestampforfilename"_speed_test_results.csv"
    echo $outputfilename
  

    #Check to see if we are creating a new file or appending an old one.  Add the headers if its new...
    headerrow="Date_Time\tSourceIP\tDockerHostName\tUsingHost\tDownload\tUpload\n"
    [ ! -e $outputfilename ] &&  printf $headerrow >>  $outputfilename

    /usr/local/bin/speedtest-cli > "$execlocaloutputfilename"
    lineout=$(date +%Y%m%d_%H%M%S_%Z)
    #echo $lineout

    #add the docker hostname to the row
    val=""
    val=$DOCKERHOSTNAME
    echo $val
    lineout="$lineout\t$val"


    #get the source IP from the output
    val=""
    val=$(grep  'Testing from ' $execlocaloutputfilename) 
    val=$(echo $val | grep --perl-regexp -o '(?<=\().*(?=\))')
    lineout="$lineout\t$val"

    #get the destination host info provided
    val=""
    srch='Hosted by '
    val=$(grep  "$srch" $execlocaloutputfilename) 
    charstosave=`expr ${#val} - ${#srch}`
    #echo $charstosave
    val=${val: -$charstosave}
    #echo $val
    lineout="$lineout\t$val"
    #echo $lineout


    #get the Down speed
    val=""
    srch='Download: '
    val=$(grep  "$srch" $execlocaloutputfilename) 
    charstosave=`expr ${#val} - ${#srch}`
    #echo $charstosave
    val=${val: -$charstosave}
    #echo $val
    lineout="$lineout\t$val"
    #echo $lineout

    #get the u[] speed
    val=""
    srch='Upload: '
    val=$(grep  "$srch" $execlocaloutputfilename) 
    charstosave=`expr ${#val} - ${#srch}`
    #echo $charstosave
    val=${val: -$charstosave}
    #echo $val
    lineout="$lineout\t$val"
    printf "$lineout\n" >> $outputfilename
    printf "$lineout\n"
    echo "ended at:  $(date +%Y%m%d_%H%M%S)"
    echo "sleeping variable SECONDSTOSLEEPBETWEENITERATIONS=$SECONDSTOSLEEPBETWEENITERATIONS"
    sleep $SECONDSTOSLEEPBETWEENITERATIONS
done
