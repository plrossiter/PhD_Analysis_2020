!/bin/bash

NUMJOBS_START=$1
NUMJOBS_FINISH=$2
home=/home/rossiter
LOGDIR=/data/rossiter/lux/logs/python/Process_MSeventRateWRTdepth_SIMS_1908

for i in `seq  $NUMJOBS_START $NUMJOBS_FINISH`
do 
	echo $i
	condor_qsub -V -o $LOGDIR/output$i.txt -e $LOGDIR/output$i.err -v ijob="$i",LOGDIR="$LOGDIR" $home/SubmissionScripts/LUX_MS_validation_190813/run.sh
	JOBID="${mat}${iso}_${process}_`printf %03d $i`.condor"
	sleep 2
done
