
in_lo=$1
in_hi=$2

source /cvmfs/sft.cern.ch/lcg/views/LCG_95/x86_64-centos7-gcc8-opt/setup.sh

for i in `seq  $in_lo $in_hi`
do     
    lo_lim="$(($i * 1000))"
    hi_lim="$(($lo_lim + 1000))"
    python /home/rossiter/Xe131m_Generator/MSSI_reducer_200325.py $lo_lim $hi_lim
    sleep 5
done