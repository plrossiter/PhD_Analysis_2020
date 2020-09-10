i=$1
ii=$2

source /cvmfs/sft.cern.ch/lcg/views/LCG_95/x86_64-centos7-gcc8-opt/setup.sh
cd /home/rossiter/LUX/GammaX_200206/XGBoost_BDT_1912/
python /home/rossiter/LUX/GammaX_200206/XGBoost_BDT_1912/BDTcut_Efficiency_Shape_2005_2.py $i $ii
cd /home/rossiter/SubmissionScripts/LUX_EFT_ShapeCuts_Efficiency_200518/
