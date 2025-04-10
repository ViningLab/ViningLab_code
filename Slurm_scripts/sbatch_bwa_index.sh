#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_bwa_index.sh  
# squeue

#SBATCH --job-name=bwaindex
#SBATCH --error=bwaindex_%A.err
#SBATCH --output=bwaindex_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
# SBATCH --partition=green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4

echo "Running on host: $HOST"

##### ##### ##### ##### #####

REF="../GCF_029168945.1_ASM2916894v1_genomic.fna.gz"
REF_NAME="Pink_pepper"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

CMD="bwa index -a bwtsw -p $REF_NAME $REF"

echo $CMD
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


##### ##### ##### ##### #####
# EOF.
