#!/bin/bash

mkdir /scratch/rossiter/luxGXAnalysis_181002
mkdir /scratch/rossiter/luxGXAnalysis_181002/$ijob
mkdir /data/rossiter/lz/baccarat/luxGXAnalysis_1e7_181002

export OUTPUT_DIR=/scratch/rossiter/luxGXAnalysis_181002/$ijob
cd $OUTPUT_DIR							
BACCARAT_DIR=/home/rossiter/LUX/GammaX_sims/LUX_BACCARAT_181001
#ROOT_DIR=/cvmfs/lz.opensciencegrid.org/ROOT/v5.34.32/slc6_gcc44_x86_64/root/
#G4_DIR=/cvmfs/lz.opensciencegrid.org/geant4/
#GVER=geant4.9.5.p02
#LIBNEST_DIR=/cvmfs/lz.opensciencegrid.org/fastNEST/
#LIBNEST_VERSION=4.1.0
MACRO_FILE=/home/rossiter/SubmissionScripts/LUX_BACCARAT_GX_BottomPMT_180914/PETERbottomPMT.mac

echo "Setup cvmfs directories"
#CONVERTER_EXE=/home/rossiter/Xe131m_Generator/ReducedAnalysis/TDRAnalysis_20170802/ReducedAnalysisTree/Bacc2AnalysisTree
#CONVERTER_DIR=/home/rossiter/Xe131m_Generator/ReducedAnalysis/TDRAnalysis_20170802/ReducedAnalysisTree/


echo "Setup converter"



# move into the LUXSim directory, set G4 env, and run the macro
cd $BACCARAT_DIR
#source ${G4_DIR}/etc/geant4env.sh ${GVER}
#source ${ROOT_DIR}/bin/thisroot.sh
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
#source /cvmfs/lz.opensciencegrid.org/fastNEST/release-3.1.1/libNEST/thislibNEST.sh 
#export BACC_TOOLS=/home/rossiter/Xe131m_Generator/ReducedAnalysis/BACCARAT_20170808/tools/
#export LD_LIBRARY_PATH=$BACC_TOOLS:$LD_LIBRARY_PATH
#echo "-> TRYING TO MAKE REDUCED FILE"
#echo "-> RUNNING"
#echo $CONVERTER_EXE
#echo $OUTPUT_DIR/$OUTPUT_REDUCED_FILE
#echo $OUTPUT_REDUCED_FILE
#echo "<-"
cd $OUTPUT_DIR
#OUTPUT_REDUCED_FILE=${OUTPUT_ROOT_FILE/".root"/"_analysis_tree.root"}	 
#$CONVERTER_EXE $OUTPUT_DIR/$OUTPUT_ROOT_FILE $OUTPUT_DIR/$OUTPUT_REDUCED_FILE	

echo "DONE."
cp $OUTPUT_DIR/$OUTPUT_ROOT_FILE /data/rossiter/lz/baccarat/luxGXAnalysis_1e7_181002/$OUTPUT_ROOT_FILE

rm -r /scratch/rossiter/luxGXAnalysis_181002/$ijob

