!/bin/bash
NUMJOBS_START=$1
NUMJOBS_FINISH=$2

source /cvmfs/sft.cern.ch/lcg/views/LCG_95/x86_64-slc6-gcc7-opt/setup.sh

home=/home/rossiter
LOGDIR=/data/rossiter/lux/logs/python/LUX_EFTdata_1S1_2S2_191016/

for ijob in `seq  $NUMJOBS_START $NUMJOBS_FINISH`
do     
    echo $ijob
    python /home/rossiter/LUX/BDT_cut_190911/Process_onefile_1S1_2S2_data.py $ijob
    sleep 5
done
