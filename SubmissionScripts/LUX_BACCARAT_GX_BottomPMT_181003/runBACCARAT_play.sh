#!/bin/bash

mkdir /scratch/rossiter/luxGXAnalysis_181003
mkdir /scratch/rossiter/luxGXAnalysis_181003/$ijob
mkdir /data/rossiter/lz/baccarat/luxGXAnalysis_1e7_181003

export OUTPUT_DIR=/scratch/rossiter/luxGXAnalysis_181003/$ijob
cd $OUTPUT_DIR							
BACCARAT_DIR=/home/rossiter/LUX/GammaX_sims/LUX_BACCARAT_181001
MACRO_FILE=/home/rossiter/SubmissionScripts/LUX_BACCARAT_GX_BottomPMT_181003/PETERbottomPMT.mac

echo "Setup cvmfs directories"

echo "Setup converter"



# move into the LUXSim directory, set G4 env, and run the macro
cd $BACCARAT_DIR

source setup.sh

echo "Sourcing BACCARAT setup script"
cd $BACCARAT_DIR/build.x86_64-slc6-gcc48-opt/bin
./BACCARATExecutable $MACRO_FILE 

echo "-> FINISHED RUNNING BACCARAT"

# after macro has run, rootify
cd $OUTPUT_DIR
OUTPUT_FILE=$(ls *.bin)	
	cd $BACCARAT_DIR/build.x86_64-slc6-gcc48-opt/bin
	./BaccRootReader $OUTPUT_DIR/$OUTPUT_FILE
	cd $OUTPUT_DIR 
OUTPUT_ROOT_FILE=$(basename $OUTPUT_FILE .bin).root	
echo "-> Converted .bin to .root"

# reduce and then copy both to our central storage.

cd $OUTPUT_DIR

echo "DONE."
cp $OUTPUT_DIR/$OUTPUT_ROOT_FILE /data/rossiter/lz/baccarat/luxGXAnalysis_1e7_181003/$OUTPUT_ROOT_FILE

rm -r /scratch/rossiter/luxGXAnalysis_181003/$ijob

