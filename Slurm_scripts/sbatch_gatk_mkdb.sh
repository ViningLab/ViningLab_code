#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_gatk_mkdb.sh  
# squeue

#SBATCH --job-name=gatk_mkdb
#SBATCH --error=gatk_mkdb_%A.err
#SBATCH --output=gatk_mkdb_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
# SBATCH --partition=green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

# https://gatk.broadinstitute.org/hc/en-us/articles/360035531652-FASTA-Reference-genome-format

FASTA="ERBxHO40_23_hirisehap1.fa"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

# Writes to the directory where the FASTA is located.
CMD="~/bin/gatk4/gatk-4.1.4.1/gatk CreateSequenceDictionary -R $FASTA"

# 
echo $CMD
# 
eval $CMD

# SAMtools doesn't like gzip.
CMD="~/bin/samtools-1.11/samtools faidx $FASTA"

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
