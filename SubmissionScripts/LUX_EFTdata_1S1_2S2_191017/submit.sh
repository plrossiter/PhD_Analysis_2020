!/bin/bash
NUMJOBS_START=$1
NUMJOBS_FINISH=$2

source /cvmfs/sft.cern.ch/lcg/views/LCG_95/x86_64-slc6-gcc7-opt/setup.sh

home=/home/rossiter
LOGDIR=/data/rossiter/lux/logs/python/LUX_EFTdata_1S1_2S2_191017/
mkdir $LOGDIR

for i in `seq  $NUMJOBS_START $NUMJOBS_FINISH`
do     
    condor_qsub -V -o $LOGDIR/output$i.txt -e $LOGDIR/output$i.err -v ijob="$i",LOGDIR="$LOGDIR" $home/SubmissionScripts/LUX_EFTdata_1S1_2S2_191017/run.sh -l mem=0.1G
    JOBID="${mat}${iso}_${process}_`printf %03d $i`.condor"
    sleep 2
done
