#!/bin/bash
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
#timestamp=${timestamp}_${AB}
numDir=${dataDir}/${run}/${iso}/${stage}/`printf %03d $iJob`
# ________________________
# print some stuff to check the variable list
printf "Running job number $iJob submited by $user on $HOSTNAME at $timestamp\n"
printf "\tiJob = $iJob\n"
printf "\tnow = $now\n"
printf "\tnumDir = $numDir\n"
printf "\tLZSimDir = $LZSimDir\n"
printf "\tTDRAnaDir = $TDRAnaDir\n"
printf "\toutName = $outName\n"
printf "\tstage = $stage\n"
if [ "$stage" != "st1" ]; then printf "\tboost = $boost\n"; fi
if [ "$stage" != "st5" ]; then printf "\tinputBiasing = $inputBiasing\n"; fi
printf "\tinputMacro = $inputMacro\n\n"

# setup G4 + ROOT + NEST
cd $LZSimDir
source $LZSimDir/setup.sh

export BACC_TOOLS=${LZSimDir}/build.${LZ_BUILD_CONFIG}/
export LD_LIBRARY_PATH=$BACC_TOOLS/lib:$LD_LIBRARY_PATH
source /cvmfs/lz.opensciencegrid.org/fastNEST/release-5.0.0/libNEST/thislibNEST.sh

# make numbered job on scratch and make sure it is empty
mkdir -p /scratch/${user}/${timestamp}_${iJob}
rm -rf /scratch/${user}/${timestamp}_${iJob}/* 

# move the binary file to the scratch
if [ "$stage" != "st1" ]
then 
    fileString="$(ls $fileDir/`printf %03d $iJob`/*.bin)"
    #printf "\tFileString = $fileString\n"
    printf "Binary file: $fileString \n"
    cp $fileString /scratch/${user}/${timestamp}_${iJob}
    binFile="$(ls /scratch/${user}/${timestamp}_${iJob}/*.bin)"
fi

# copy macro file to job LZSimDir and make substitutions
cp $inputMacro $LZSimDir/Submit/$now/$outName$iJob.mac
if [ "$stage" != "st5" ]; then cp $inputBiasing $LZSimDir/Submit/$now/$outName$iJob.txt; fi
export OUTPUTDIR=/scratch/${user}/${timestamp}_${iJob}
export OUTPUTNAME=$outName
if [ "$stage" != "st1" ]
then 
    export BININPUT=$binFile
    export BOOST=$boost
fi

printf "\nMacro commands;\n\t"
printf "OutputDir: /scratch/${user}/${timestamp}_${iJob} \n\t" 
printf "OutputName: $outName \n\t"
if [ "$stage" != "st1" ]
then
    printf "BinaryInput: $binFile \n\t"
    printf "Boost: $boost \n\t"
fi

# run BACCARAT
if [ "$stage" != "st5" ]
then 
    printf "Trying to run\n\t ./build.${LZ_BUILD_CONFIG}/bin/BACCARATExecutable Submit/$now/$outName$iJob.mac Submit/$now/$outName$iJob.txt \n"
    ./build.${LZ_BUILD_CONFIG}/bin/BACCARATExecutable Submit/$now/$outName$iJob.mac Submit/$now/$outName$iJob.txt
else
    printf "Trying to run\n\t ./build.${LZ_BUILD_CONFIG}/bin/BACCARATExecutable Submit/$now/$outName$iJob.mac \n"
    ./build.${LZ_BUILD_CONFIG}/bin/BACCARATExecutable Submit/$now/$outName$iJob.mac
fi

if [ "$stage" != "st1" ]
then 
    printf "Removing $binFile\n"
    rm -rf $binFile  
fi     
myFile=$(ls /scratch/${user}/${timestamp}_${iJob}/*.bin)
echo "Converting $myFile to root"

# do conversion
cd /scratch/${user}/${timestamp}_${iJob}/
$LZSimDir/build.${LZ_BUILD_CONFIG}/bin/BaccRootReader $myFile

# baccout="$(ls *.root)"
# $TDRAnaDir/ReducedAnalysisTree/Bacc2AnalysisTree $baccout ${baccout//.root}_reduced.root 

# mv $baccout ${baccout//.root}_convert.root

# move the output
printf "\nAfter conversion, scratch contains;\n\t"
printf "$(ls -lh /scratch/${user}/${timestamp}_${iJob})\n"
if [ "$stage" != "st5" ]; then mv /scratch/${user}/${timestamp}_${iJob}/$outName*.bin $numDir; fi
#mv /scratch/${user}/${timestamp}_${iJob}/$outName*reduced.root $numDir
mv /scratch/${user}/${timestamp}_${iJob}/*.root $numDir
#mv /scratch/${user}/${timestamp}_${iJob}/* $numDir #just for testing ;; remove it before deployment

# clean up
rm -rf /scratch/${user}/${timestamp}_${iJob}
