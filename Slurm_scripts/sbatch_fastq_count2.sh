#! /usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_fastq_count.sh  
# squeue

#SBATCH --job-name=fqc
#SBATCH --error=fqc_%A.err
#SBATCH --output=fqc_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

HOST=$(hostname)
echo ‘Running on host: %s\n’ $HOST 

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

# The caret (^) anchors the regular expression to the begining of the string.
MY_REGEX="^@"
CMD="zgrep -c $MY_REGEX *fastq.gz > counts.txt"

echo $CMD
eval $CMD


# EOF.
