NUMJOBS_START=$1
NUMJOBS_FINISH=$2

for ijob in `seq  $NUMJOBS_START $NUMJOBS_FINISH`
do  
    echo $ijob
    source runBACCARAT_play.sh
    sleep 2
    cd /home/rossiter/SubmissionScripts/LUX_BACCARAT_GX_BottomPMT_K40_190520
done
