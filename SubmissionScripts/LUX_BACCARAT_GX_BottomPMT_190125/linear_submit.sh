NUMJOBS_START=$1
NUMJOBS_FINISH=$2

for i in `seq  $NUMJOBS_START $NUMJOBS_FINISH`
do
    cd /home/rossiter/SubmissionScripts/LUX_BACCARAT_GX_BottomPMT_190125
    source runBACCARAT_play.sh
    sleep 2
done