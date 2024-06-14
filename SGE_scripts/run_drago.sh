#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub run_drago.sh

# https://github.com/sequentiabiotech/DRAGO-API


#$ -cwd # Execute from current working directory.
#$ -S /bin/bash # Use bash.
#$ -N drago # Job name.
#$ -e dragerr # Where to redirect standard error.
#$ -o dragout # Where to redirect standard out.
#$ -q (hoser) # Queue(s), regex style.
# $ -l mem_free=10G # Memory requirement.
# $ -pe thread 4 # Thread requirement.
#$ -V # Export current environment variables.
# $ -h # Submit job with a hold.

##### ##### ##### ##### #####
# Report what we ended up with

echo "Using shell: "$0
echo "PATH:"
echo $PATH
echo

echo -n "Running on: "
hostname
echo "SGE job id: $JOB_ID"
date
echo


##### ##### ##### ##### #####
# 

DRAGO="/home/bpp/knausb/gits/DRAGO-API/drago-api.sh"
PROTEINS="../braker3_v2/braker.aa"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

CMD="$DRAGO drago3 $PROTEINS > drago_output.txt"

echo $CMD
eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


# EOF.
