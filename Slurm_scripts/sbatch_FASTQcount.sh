#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_FASTQcount.sh  
# squeue

#SBATCH --job-name=FQcnt
#SBATCH --error=FQcnt_%A.err
#SBATCH --output=FQcnt_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1


HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

CMD="zgrep -c '^@' *fastq.gz > counts.txt"
echo $CMD
eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

##### ##### ##### ##### #####
# EOF.
