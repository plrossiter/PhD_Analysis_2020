!/bin/bash
z_lo=$1
z_hi=$2
z_epsilon=$3
home=/home/rossiter
LOGDIR=/data/rossiter/lux/logs/EFT_ShapeCuts_Efficiency_0518
mkdir $LOGDIR
source /cvmfs/sft.cern.ch/lcg/views/LCG_95/x86_64-centos7-gcc8-opt/setup.sh
# -e - error stream
# -o - output stream
# -V - ?
# -v - ? passing varibales to a script?
#I can't get this thing to work :(
for i in `seq  $z_lo $z_epsilon $z_hi`
do     
    condor_qsub -V -o $LOGDIR/output$i.txt -e $LOGDIR/output$i.err -v z="$i",LOGDIR="$LOGDIR" run.sh $i $((i+1))
    JOBID="${mat}${iso}_${process}_`printf %03d $i`.condor"
    sleep 2

done

