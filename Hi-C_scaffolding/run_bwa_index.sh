#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub run_bwa_index.sh

#$ -cwd # Execute from current working directory.
#$ -V # Export current environment variables.
#$ -S /bin/bash # Use bash.
#$ -N bwa # Job name.
#$ -e bwaerr # Where to redirect standard error.
#$ -o bwaout # Where to redirect standard out.
#$ -q (hoser) # Queue(s), regex style.
# $ -l mem_free=10G # Memory requirement.
# $ -pe thread 4 # Thread requirement.

# $ -h # Submit job with a hold.
# $ -t 1-2:1 # Task array for batch jobs.

# Create a 0-based counter from 1-based SGE.
#i=$(expr $SGE_TASK_ID - 1)

echo "Using shell: "$0
echo "PATH:"
echo $PATH
echo


##### ##### ##### ##### #####
# Report what we ended up with

echo -n "Running on: "
hostname
echo "SGE job id: $JOB_ID"
date
echo

REF=""

#CMD="$BWA mem -M -R \"$RG\" $BREF ${arr[1]} ${arr[2]} > sams/${arr[0]}.sam"
CMD="bwa index $REF"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

echo $CMD

# Uncomment the following line to execute/evaluate.
# eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF.
