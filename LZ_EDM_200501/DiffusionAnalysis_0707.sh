
in_lo=$1
in_hi=$2
r_in=$3

mkdir /data/rossiter/lz/EDM_DiffusionAnalysis_2007/r$r_in

for i in `seq  $in_lo $in_hi`
do     
    ./eDriftCalc_0707/SingleDiffusionLineMC_TimeStep $r_in 2.0 0504 .32 /data/rossiter/lz/EDM_DiffusionAnalysis_2007/.
    sleep 1
    mv /data/rossiter/lz/EDM_DiffusionAnalysis_2007/SingleDiffusionLineMC_TimeStep_.32us_r$r_in* /data/rossiter/lz/EDM_DiffusionAnalysis_2007/r$r_in/SingleDiffusionLineMC_TimeStep_.32us_r$r_in._$i.txt
done
