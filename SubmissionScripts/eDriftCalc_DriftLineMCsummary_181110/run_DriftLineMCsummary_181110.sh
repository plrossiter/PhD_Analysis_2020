#!/bin/bash                                                                                                                    

echo "Setup executable input arguments"
#InputFilename=/home/rossiter/XYZPositionCorrector/nonlinear100kv_gridhalf_4_5.txt
#Date=0906
#StepTime=1
#rjob=0.5
zjob=1.5
echo "Making scratch & data directories"
mkdir /scratch/rossiter/DriftMC_$Date
mkdir /scratch/rossiter/DriftMC_$Date/$rjob
mkdir /data/rossiter/lz/DriftMC_$Date
mkdir /data/rossiter/lz/DriftMC_$Date/Output/

echo "Setup Directories"
export OUTPUT_DIR=/scratch/rossiter/DriftMC_$Date/$rjob
export EXPORT_DIR=/data/rossiter/lz/DriftMC_$Date/Output/
export EXECUTABLE_DIR=/home/rossiter/XYZPositionCorrector/eDriftCalc_1811_2/

## move into the XYZPositionCorrector directory, and run the macro                                               

echo $rjob       
echo "Sourcing EXECUTABLE setup script"
cd $EXECUTABLE_DIR
./IndividualDiffusionAnalysis_TimeStep $InputFilename $rjob $zjob $Date $StepTime $OUTPUT_DIR

echo "-> FINISHED RUNNING EXECUTABLE"

## after macro has run                                                                                        
cd $OUTPUT_DIR
OUTPUT_FILE=$(ls *.txt)

echo "DONE."
mv $OUTPUT_DIR/* $EXPORT_DIR/.
rm -r $OUTPUT_DIR
cd $EXPORT_DIR