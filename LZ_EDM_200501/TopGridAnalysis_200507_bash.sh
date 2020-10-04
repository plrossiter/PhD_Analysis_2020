
mkdir /data/rossiter/lz/TopGridAnalysis_Dense_200508/

for r in `seq  0.85 0.001 2.`
do     
    ./eDriftCalc/SingleDriftLineCalc_exe $r 144.9 0507 0.0001 /data/rossiter/lz/TopGridAnalysis_Dense_200508/.
    sleep 1
done

