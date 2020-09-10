
in_lo=$1
in_hi=$2
home=/home/rossiter
LOGDIR=/data/rossiter/lz/logs/baccarat/Xe131mBGAnalysis_1e10_171012_Reduced_MSSI_200329/
#	mkdir $LOGDIR

# -e - error stream
# -o - output stream
# -V - ?
# -v - ? passing varibales to a script?

for i in `seq  $in_lo $in_hi`
do     
    lo_lim="$(($i * 1000))"
    hi_lim="$(($lo_lim + 1000))"
    condor_qsub -V -o $LOGDIR/output$i.txt -e $LOGDIR/output$i.err -v ijob="$i",LOGDIR="$LOGDIR"  $home/Xe131m_Generator/MSSI_reducer_200325.py $lo_lim $hi_lim 
    JOBID="${mat}${iso}_${process}_`printf %03d $i`.condor"
    sleep 2
done


