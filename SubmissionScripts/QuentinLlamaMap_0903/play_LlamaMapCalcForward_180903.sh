#!/bin/bash                                                                                                                    

echo "Setup executable input arguments"
InputFilename=/home/rossiter/XYZPositionCorrector/nonlinear100kv_gridhalf_4_5.txt
Date=0906
StepTime=1
rjob=0.1
echo "Making scratch & data directories"
#mkdir /scratch/rossiter/SimsMapMaker_180809
#mkdir /scratch/rossiter/SimsMapMaker_180809/$zjob
#mkdir /data/rossiter/lz/XYZPositionCorrector/SimsMapMaker_180809
##for zjob in $(seq 0.0 0.1 145.4)
                                                                                              
for zjob in $(seq 15.1 0.1 30.0)
do
        #mkdir /scratch/rossiter/SimsMapMaker_180809/$zjob/$ijob
    echo $zjob
        echo "Setup Directories"
        export OUTPUT_DIR=/data/rossiter/lz/QuentinLlamaMap/Output/
        #export EXPORT_DIR=/data/rossiter/lz/XYZPositionCorrector/SimsMapMaker_180809
        export EXECUTABLE_DIR=/home/rossiter/XYZPositionCorrector/1809_version/

        ## move into the XYZPositionCorrector directory, and run the macro                                                      
        echo "Sourcing EXECUTABLE setup script"
        cd $EXECUTABLE_DIR
        ./LlamaMapCalcForward $InputFilename $rjob $zjob $Date $StepTime $OUTPUT_DIR

        echo "-> FINISHED RUNNING EXECUTABLE"

        ## after macro has run, rootify                                                                                         
        #cd $OUTPUT_DIR
        #OUTPUT_FILE=$(ls *.txt)

        echo "DONE."
        #cp $OUTPUT_DIR/$OUTPUT_FILE $EXPORT_DIR/$OUTPUT_FILE


        #rm -r $OUTPUT_DIR
done
cd $OUTPUT_DIR