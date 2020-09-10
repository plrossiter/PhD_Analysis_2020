#!/bin/bash                                                                                                                    

echo "Setup executable input arguments"
#InputFilename=/home/rossiter/XYZPositionCorrector/nonlinear100kv_gridhalf_4_5.txt
#Date=0906
#StepTime=1
#rjob=0.5
zjob=145.1
echo "Making scratch & data directories"
mkdir /scratch/rossiter/DriftCalc_$Date
mkdir /scratch/rossiter/DriftCalc_$Date/$rjob
mkdir /data/rossiter/lz/DriftCalc_$Date
mkdir /data/rossiter/lz/DriftCalc_$Date/Output/

echo "Setup Directories"
export OUTPUT_DIR=/scratch/rossiter/DriftCalc_$Date/$rjob
export EXPORT_DIR=/data/rossiter/lz/DriftCalc_$Date/Output/
export EXECUTABLE_DIR=/home/rossiter/XYZPositionCorrector/eDriftCalc_1811_2

## move into the XYZPositionCorrector directory, and run the macro                                               

echo $rjob       
echo "Sourcing EXECUTABLE setup script"
cd $EXECUTABLE_DIR
./SingleDriftLineCalc_TimeStep $InputFilename $rjob $zjob $Date $StepTime $OUTPUT_DIR
echo "-> FINISHED RUNNING EXECUTABLE"

## after macro has run                                                                                        
cd $OUTPUT_DIR
OUTPUT_FILE=$(ls *.txt)

echo "DONE."
cp $OUTPUT_DIR/$OUTPUT_FILE $EXPORT_DIR/$OUTPUT_FILE
rm -r $OUTPUT_DIR
cd $EXPORT_DIR