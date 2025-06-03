#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_fastq_count.sh  
# squeue

#SBATCH --job-name=FQ
#SBATCH --error=FQerr/bwa%A_%a.err
#SBATCH --output=FQout/bwa%A_%a.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=1

##### ##### ##### ##### #####

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

NCPU=8

CMD="$BWA mem -t $NCPU -M -R \"$RG\" $DBPREFIX ${arr[1]} ${arr[2]} | $SAMT view -@ $NCPU -bh > bams/"${arr[0]}".bam"


#
echo $CMD
#
eval $CMD

CMD="zgrep -c '^@' *fastq.gz > counts.txt"

#
echo $CMD
#
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

##### ##### ##### ##### #####
# EOF.
