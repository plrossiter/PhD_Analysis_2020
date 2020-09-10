!/bin/bash
z_lo=$1
z_hi=$2
z_epsilon=$3
home=/home/rossiter
LOGDIR=/data/rossiter/lz/logs/baccarat/eDrift_200506/
mkdir $LOGDIR


mkdir /data/rossiter/lz/TopGridAnalysis_Dense_200508/
# -e - error stream
# -o - output stream
# -V - ?
# -v - ? passing varibales to a script?
#I can't get this thing to work :(
for i in `seq  $z_lo $z_epsilon $z_hi`
do     
    condor_qsub -V -o $LOGDIR/output$i.txt -e $LOGDIR/output$i.err -v ijob="$i",LOGDIR="$LOGDIR" /home/rossiter/SubmissionScripts/eDriftCalc_DriftLine_TopGateAnalysis_200507/run.sh $i
    JOBID="${mat}${iso}_${process}_`printf %03d $i`.condor"
    sleep 2

done

