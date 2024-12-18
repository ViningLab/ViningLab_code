#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_blastn.sh  
# squeue

#SBATCH --job-name=blastn
#SBATCH --error=blastn_%A.err
#SBATCH --output=blastn_%A.out
# SBATCH --partition=hoser
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8
#SBATCH --array=0-9

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

