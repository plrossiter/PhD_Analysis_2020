!/bin/bash

#FirstDriftLine=$1
FirstzRow=$1
#LastDriftLine=$2
LastzRow=$2
LineInterval=$3
StepTime=$4
InputFilename=$5
Date=$6

home=/home/rossiter
LOGDIR=/home/rossiter/SubmissionScripts/QuentinLlamaMap_0903/logs
mkdir $LOGDIR
cd $home/XYZPositionCorrector/1809_version/
g++ 1809_LlamaMapCalcForward.cpp -o CondorLlamaMapCalcForward
# -e - error stream                                                                                                                             
# -o - output stream                                                                                                                            
# -V - ?                                                                                                                                        
# -v - ? passing varibales to a script?                                                                                                         
for i in $(seq $1 $3 $2)
do
    condor_qsub -V -o $LOGDIR/output$i.txt -e $LOGDIR/output$i.err -v zjob="$i",LOGDIR="$LOGDIR",Date="$Date",InputFilename="$InputFilename",St\
epTime="$StepTime"  $home/SubmissionScripts/QuentinLlamaMap_0903/run_LlamaMapCalcForward_180903.sh
    JOBID="${mat}${iso}_${process}_`printf %03d $i`.condor"
    sleep 2
done

