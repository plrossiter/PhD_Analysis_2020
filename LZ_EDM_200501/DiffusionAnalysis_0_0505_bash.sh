
in_lo=$1
in_hi=$2
r_in=$3

mkdir /data/rossiter/lz/EDM_DiffusionAnalysis_2005_2/r0$r_in

for i in `seq  $in_lo $in_hi`
do     
    ./eDriftCalc/SingleDiffusionLineMC_TimeStep_exe $r_in 2.0 0504 .32 /data/rossiter/lz/EDM_DiffusionAnalysis_2005_2/.
    sleep 1
    mv /data/rossiter/lz/EDM_DiffusionAnalysis_2005_2/SingleDiffusionLineMC_TimeStep_.32us_r0$r_in* /data/rossiter/lz/EDM_DiffusionAnalysis_2005_2/r0$r_in/SingleDiffusionLineMC_TimeStep_.32us_r0$r_in._$i.txt
done

