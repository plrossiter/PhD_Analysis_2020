!/bin/bash

NUMJOBS_START=$1
NUMJOBS_FINISH=$2
home=/home/rossiter
LOGDIR=/data/rossiter/lz/logs/baccarat/luxGXAnalysis_1e7_K40_190208
	mkdir $LOGDIR
# -e - error stream
# -o - output stream
# -V - ?
# -v - ? passing varibales to a script?
for i in `seq  $NUMJOBS_START $NUMJOBS_FINISH`
do     
    condor_qsub -V -o $LOGDIR/output$i.txt -e $LOGDIR/output$i.err -v ijob="$i",LOGDIR="$LOGDIR" $home/SubmissionScripts/LUX_BACCARAT_GX_BottomPMT_K40_190208/runBACCARAT_play.sh -l mem=1.2G
    JOBID="${mat}${iso}_${process}_`printf %03d $i`.condor"
    sleep 2
done
