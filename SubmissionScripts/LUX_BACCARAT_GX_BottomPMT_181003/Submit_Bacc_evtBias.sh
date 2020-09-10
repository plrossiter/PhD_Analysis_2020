#!/usr/bin/env bash

###############################
# Andrew Naylor 11th May 2018 # (modified from a script provided by David Woodward)
###############################

# - 24th May 2018 - Moved to condor_submit from qsub (Andrew Naylor)

## TO-DO
#----------
# [] - add option to parse what files are kept
#     i.e. all or just the reduced and whether
#     to run reduced or not

#   check an input argument is given
if [ $# -ne 2 ]
then
  echo " --> Error, use 'source setup.sh <startnum> <numJobs>' where start num = which number the jobs are starting on and numJobs = number of jobs to submit"
  return
fi

declare -A parameters=()

# functions
function export_vars {
    for var in "${!parameters[@]}"; do export $var=${parameters[$var]}; done
}

function export_vars_print {
    for var in "${!parameters[@]}"; do echo "$var=${parameters[$var]}"; done
}

function unset_vars {
    echo "Unsetting variables"
    for var in "${!parameters[@]}"; do unset $var; done
}

parameters+=([STARTNUM]=$1)
parameters+=([NUMJOBS]=$2)
parameters+=([maxjobtime]=36) #in hours

###  ----------------------------------------------------------------------
###  Optional Arguments: Check these for each submission 
###  ----------------------------------------------------------------------

#    what version of the code do you want to use?
parameters+=([LZSimDir]=/home/anaylor/lzsim/sally_g4_10_rock_gammas)
parameters+=([TDRAnaDir]=/home/anaylor/lzsim/g4_10_TDRAnalysis)
parameters+=([exec]=Bacc_evtbias_sims.sh)
#Bacc_evtbias_sims_1000.sh

#    what is the output name you want to use?
parameters+=([run]="run_6")
parameters+=([iso]="Th232")
parameters+=([stage]="st1")
parameters+=([outName]="lz_rG_${parameters[iso]}_${parameters[stage]}_")


#   check if not stage 1, then which folder from the previous stage and boost factor=100 (except for k40 st5)
if [ "${parameters[stage]}" != "st1" ]
then
    parameters+=([fileDir]="/data/anaylor/LZ/${parameters[run]}/${parameters[iso]}/st$((${parameters[stage]//st}-1))/")
    parameters+=([boost]=100)
fi
#boost should be 1000 for final stage of k40 but because it's getting split into more jobs, lower boost number.

#    what are the input macros and txt files for this batch of jobs?
if [ "${parameters[stage]}" == "st1" ]
then 
    parameters+=([inputMacro]=${parameters[LZSimDir]}/Submit/macros/stage_${parameters[stage]//st}_${parameters[iso]}.mac)
else
    parameters+=([inputMacro]=${parameters[LZSimDir]}/Submit/macros/stage_${parameters[stage]//st}.mac)
fi
if [ "${parameters[stage]}" != "st5" ]; then parameters+=([inputBiasing]=${parameters[LZSimDir]}/Submit/macros/stage_${parameters[stage]//st}.txt); fi

###  ----------------------------------------------------------------------
###  ----------------------------------------------------------------------


#    set up directories
parameters+=([home]=$PWD)
parameters+=([user]=$USER)
parameters+=([now]=$(date +"%Y-%m-%d_%H-%M-%S"))
parameters+=([dataDir]=/data/${parameters[user]}/LZ)

#    make some directories
mkdir ${parameters[LZSimDir]}/Submit/${parameters[now]}
mkdir -p ${parameters[dataDir]}/${parameters[run]}/${parameters[iso]}/${parameters[stage]}/outputs

echo "Setting variables ready for *.submit"
unset_vars
export_vars
export_vars_print | tee log_${parameters[outName]}${parameters[now]}.txt

echo "Do you want to proceed with these variables?"
read -p "Press enter to continue..."

echo "Running ${parameters[NUMJOBS]} jobs on the cluster"
echo "____________________________________"

for i in `seq ${parameters[STARTNUM]} $((${parameters[STARTNUM]}+${parameters[NUMJOBS]}-1))`
do 
    numDir=${parameters[dataDir]}/${parameters[run]}/${parameters[iso]}/${parameters[stage]}/`printf %03d $i`
    mkdir $numDir
done
    
# __________________________________________________
# submit using the condor submission system

# give the node script correct permissions
chmod +x ${parameters[home]}/${parameters[exec]}
#Bacc_evtbias_sims.sh

# determine from the stage which command to run to parse the script to the node
condor_submit Condor_Bacc_evtbias.submit
# sleep 5

unset_vars
#   load the crontab to check job completion every 10 minutes
crontab /home/anaylor/lzsim/g4_10_rock_gammas/Submit/pyCheck/cron_backup.txt
