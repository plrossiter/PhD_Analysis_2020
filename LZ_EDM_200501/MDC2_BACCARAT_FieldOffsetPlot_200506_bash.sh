
z=$1

for r in `seq  0 .4 72.8`
do     
    echo $r
    ./eDriftCalc_200505/SingleDriftLineCalc_exe $r $z 0506 .05 /data/rossiter/lz/mdc2_DriftMap_200506/.
done
